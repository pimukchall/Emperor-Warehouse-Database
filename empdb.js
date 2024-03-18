const cors = require("cors");
const express = require("express");
const mysql = require("mysql2");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const bcrypt = require("bcrypt");

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "empdb",
});

const app = express();
app.use(express.json());
app.use(cors({ 
  credentials: true,
  origin: ['http://localhost:3000'] 
}));
app.use(cookieParser());

app.use(session({
  secret: 'secret',
  resave: false,
  saveUninitialized: true,
}));

const port = 3001
const secret = 'mysecret'

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

app.get("/", function (req, res, next) {
  res.send("Hello My EMP!");
});

app.get("/test", function (req, res, next) {
  res.json({ message : "Hello My EMP!" })
});

// Login ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

app.post("/api/user/login", async (req, res) => {
  try {
    const { email, password } = req.body
    const [results] = await connection.promise().query("SELECT * FROM `users` WHERE `email` = ?", email)
    const userData = results[0]
    const match = await bcrypt.compare(password, userData.password)
    if (!match) {

      return res.status(400).json({
        message: 'Login failed(Invalid email or password)'
      })
      return false
    }

    const token = jwt.sign({ email: userData.email, id: userData.id }, secret, { expiresIn: '1h' })
    res.cookie('token', token, { 
      maxAge: 300000,
      secure: true,
      httpOnly: true,
      sameSite: 'none',
     })

    res.json({
      message: "Login success",
      token,
    })
  } catch (error) {
    console.log('error', error)
    res.status(401).json({
      message: "Login failed",
      error
    })
  }
});

app.get("/api/user", async (req, res) => {
  try{
    const authToken = req.cookies.token
    console.log('authToken', authToken)
    const user = jwt.verify(authToken, secret)
    const [checkResults] = await connection.promise().query('SELECT * FROM users WHERE email = ?', [user.email])
    
    if (checkResults.length === 0) {
      throw { message: 'user not found' }
    }

    const [results] = await connection.promise().query('SELECT * FROM users')
    res.json({
      users: results,
    })
  } catch (error) {
    console.log('error', error)
    res.status(403).json({
      message: 'authentication failed',
      error
    })
  }
})

// Users ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app.get("/api/users", function (req, res, next) {
  connection.query("SELECT * FROM `users`", function (err, results, fields) {
    res.json(results);
  });
});

app.get("/api/users/departments", function (req, res, next) {
  connection.query("SELECT `id`, `fname`, `lname`, `name_department`, `email`, `username`, `password`, `phone`, `date_in`, `avatar` FROM `users` JOIN departments ON users.id_department = departments.id_department", function (err, results, fields) {
    res.json(results);
  });
});

app.get("/api/users/:id", function (req, res, next) {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM `users` WHERE `id` = ?",
    [id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/users/register", async (req, res) => {
  try {
    const { fname, lname, id_department, email, username, password, phone, date_in, avatar } = req.body
    const passwordHash = await bcrypt.hash(password, 10)
    const userData = {
      fname,
      lname,
      id_department,
      email,
      username,
      password: passwordHash,
      phone,
      date_in,
      avatar
    }
    const [results] = await connection.promise().query("INSERT INTO `users` SET ?", userData)
    res.json({
      message: "Register success",
      results
    })
    } catch (error) {
      console.log(error)
      res.json({
        message: "Register failed",
        error
      })
    }
});
app.put("/api/users/update", function (req, res, next) {
  connection.query(
    "UPDATE `users` SET `fname`= ?, `lname`= ?, `id_department`= ?, `email`= ?, `username`= ?, `password`= ?, `phone`= ?, `avatar`= ? WHERE id = ?",
    [
      req.body.fname,
      req.body.lname,
      req.body.id_department,
      req.body.email,
      req.body.username,
      req.body.password,
      req.body.phone,
      req.body.avatar,
      req.body.id,

    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/users/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `users` WHERE id = ?",
      [req.query.id],
      (err, results) => {
        if (err) {
          res.status(500).json({ err });
        }
        return res.status(200).json(results);
      }
    );
  } catch (error) {}
});

// notebooks -----------------------------------------------------------------------------------------------------------
app.get("/api/notebooks", function (req, res, next) {
  connection.query(
    "SELECT * FROM `notebooks`",
    function (err, results, fields) {
      res.json(results);
    }
  );
});

app.get("/api/notebooks/:id_notebook", function (req, res, next) {
  const id_notebook = req.params.id_notebook;
  connection.query(
    "SELECT * FROM `notebooks` WHERE `id_notebook` = ?",
    [id_notebook],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/notebooks/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `notebooks`(`brand`, `model`, `cpu`, `gpu`, `ram`, `storage`, `os`, `asset_number`, `license_window`, `id`, `id_store` , `note`, `date_in`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
    [
      req.body.brand,
      req.body.model,
      req.body.cpu,
      req.body.gpu,
      req.body.ram,
      req.body.storage,
      req.body.os,
      req.body.asset_number,
      req.body.license_window,
      req.body.id,
      req.body.id_store,
      req.body.note,
      req.body.date_in,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/notebooks/update", function (req, res, next) {
  connection.query(
    "UPDATE `notebooks` SET `brand`= ?, `model`= ?, `cpu`= ?, `gpu`= ?, `ram`= ?, `storage`= ?, `os`= ?, `asset_number`= ?, `license_window`= ?, `id`= ?, `id_store`= ?, `note`= ?, `date_in`= ? WHERE id_notebook = ?",
    [
      req.body.brand,
      req.body.model,
      req.body.cpu,
      req.body.gpu,
      req.body.ram,
      req.body.storage,
      req.body.os,
      req.body.asset_number,
      req.body.license_window,
      req.body.id,
      req.body.id_store,
      req.body.note,
      req.body.date_in,
      req.body.id_notebook,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/notebooks/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `notebooks` WHERE id_notebook = ?",
      [req.query.id_notebook],
      (err, results) => {
        if (err) {
          res.status(500).json({ err });
        }
        return res.status(200).json(results);
      }
    );
  } catch (error) {}
});

// equipments -----------------------------------------------------------------------------------------------------------
app.get("/api/equipments", function (req, res, next) {
  connection.query(
    "SELECT * FROM `equipments`",
    function (err, results, fields) {
      res.json(results);
    }
  );
});

app.get("/api/equipments/:id_equipment", function (req, res, next) {
  const id_equipment = req.params.id_notebook;
  connection.query(
    "SELECT * FROM `equipments` WHERE `id_equipment` = ?",
    [id_equipment],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/equipments/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `equipments`(`equipment_name`, `id_location`, `id`, `id_store` , `asset_number`, `department_number`, `price`, `note`, `image`, `date_in`, `date_out`) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
    [
      req.body.equipment_name,
      req.body.id_location,
      req.body.id,
      req.body.id_store,
      req.body.asset_number,
      req.body.department_number,
      req.body.price,
      req.body.note,
      req.body.image,
      req.body.date_in,
      req.body.date_out,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/equipments/update", function (req, res, next) {
  connection.query(
    "UPDATE `equipments` SET `equipment_name`= ?, `id_location`= ?, `id`= ?, `id_store`= ?, `asset_number`= ?, `department_number`= ?, `price`= ?, `note`= ?, `image`= ?, `date_in`= ?, `date_out`= ? WHERE id_equipment = ?",
    [
      req.body.equipment_name,
      req.body.id_location,
      req.body.id,
      req.body.id_store,
      req.body.asset_number,
      req.body.department_number,
      req.body.price,
      req.body.note,
      req.body.image,
      req.body.date_in,
      req.body.date_out,
      req.body.id_equipment,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});
app.delete("/api/equipments/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `equipments` WHERE id_equipment = ?",
      [req.query.id_equipment],
      (err, results) => {
        if (err) {
          res.status(500).json({ err });
        }
        return res.status(200).json(results);
      }
    );
  } catch (error) {}
});

// locations -----------------------------------------------------------------------------------------------------------
app.get("/api/locations", function (req, res, next) {
  connection.query(
    "SELECT * FROM `locations`",
    function (err, results, fields) {
      res.json(results);
    }
  );
});

app.get("/api/locations/:id_location", function (req, res, next) {
  const id_location = req.params.id_location;
  connection.query(
    "SELECT * FROM `locations` WHERE `id_location` = ?",
    [id_location],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/locations/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `locations`(`id_location`, `location_name`, `address`) VALUES (?,?,?)",
    [req.body.id_location, req.body.location_name, req.body.address],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/locations/update", function (req, res, next) {
  connection.query(
    "UPDATE `locations` SET `id_location`= ?, `location_name`= ?, `address`= ? WHERE id_location = ?",
    [
      req.body.id_location,
      req.body.location_name,
      req.body.address,
      req.body.id_location,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/locations/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `locations` WHERE id_location = ?",
      [req.query.id_location],
      (err, results) => {
        if (err) {
          res.status(500).json({ err });
        }
        return res.status(200).json(results);
      }
    );
  } catch (error) {}
});

// departments -----------------------------------------------------------------------------------------------------------
app.get("/api/departments", function (req, res, next) {
  connection.query(
    "SELECT * FROM `departments`",
    function (err, results, fields) {
      res.json(results);
    }
  );
});

app.get("/api/departments/:id_department", function (req, res, next) {
  const id_department = req.params.id_department;
  connection.query(
    "SELECT * FROM `departments` WHERE `id_department` = ?",
    [id_department],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/departments/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `departments`(`id_department`, `department_name`) VALUES (?,?)",
    [req.body.id_department, req.body.department_name],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/departments/update", function (req, res, next) {
  connection.query(
    "UPDATE `departments` SET `id_department`= ?, `department_name`= ? WHERE id_department = ?",
    [req.body.id_department, req.body.department_name, req.body.id_department],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/departments/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `departments` WHERE id_department = ?",
      [req.query.id_department],
      (err, results) => {
        if (err) {
          res.status(500).json({ err });
        }
        return res.status(200).json(results);
      }
    );
  } catch (error) {}
});

// stores -----------------------------------------------------------------------------------------------------------
app.get("/api/stores", function (req, res, next) {
  connection.query("SELECT * FROM `stores`", function (err, results, fields) {
    res.json(results);
  });
});

app.get("/api/stores/:id_store", function (req, res, next) {
  const id_store = req.params.id_store;
  connection.query(
    "SELECT * FROM `stores` WHERE `id_store` = ?",
    [id_store],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/stores/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `stores`(`id_store`, `name_store`) VALUES (?,?)",
    [req.body.id_store, req.body.name_store],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/stores/update", function (req, res, next) {
  connection.query(
    "UPDATE `stores` SET `id_store`= ?, `name_store`= ? WHERE id_store = ?",
    [req.body.id_store, req.body.name_store, req.body.id_store],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/stores/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `stores` WHERE id_store = ?",
      [req.query.id_store],
      (err, results) => {
        if (err) {
          res.status(500).json({ err });
        }
        return res.status(200).json(results);
      }
    );
  } catch (error) {}
});
