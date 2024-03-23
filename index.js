const cors = require("cors");
const express = require("express");
const mysql = require("mysql2");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookie-parser");
const bcrypt = require("bcrypt");
const multer  = require('multer')
const upload = multer({ dest: 'uploads/' })

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "empdb",
});

const app = express();

app.use(express.json());

const allowedOrigins = ['https://emp-app-ten.vercel.app', 'http://localhost:3000'];
const corsOptions = {
  origin: function (origin, callback) {
    if (allowedOrigins.includes(origin) || !origin) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
};

app.use(cors(corsOptions));

app.use(cookieParser());
const port = 3001
const secret = 'mysecret'

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

app.get("/", function (req, res, next) {
  res.send("The Emperor House API is working");
});

// Login ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

app.post("/api/users/login", async (req, res) => {
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
      success: true,
        token: token,
    })

  } catch (error) {
    console.log('error', error)
    res.status(401).json({
      message: "Login failed",
      error
    })
  }
});

app.get("/api/users/me", async (req, res) => {
  try {
    const token = req.cookies.token
    console.log('token', token)
    if (!token) {
      return res.status(401).json({ message: 'Unauthorized' })
    }
    const decoded = jwt.verify(token, secret)
    const [results] = await connection.promise().query('SELECT * FROM users WHERE id = ?', decoded.id)
    const userData = results[0]
    res.json({
      user: {
        id: userData.id,
        fname: userData.fname,
        lname: userData.lname,
        email: userData.email
      }
    })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Internal server error' })
  }
})

app.delete("/api/users/logout", (req, res) => {
  res.clearCookie('token')
  res.json({ message: 'Logged out' })
})

// Users ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

app.get("/api/users", async (req, res) => {
  connection.query( "SELECT * FROM `users`",
  function (err, results, fields) {
    res.json(results);
  }
  );
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
    const { fname, lname, department_id, role_id, email, password, phone, date_in, image } = req.body
    const passwordHash = await bcrypt.hash(password, 10)
    const userData = {
      fname,
      lname,
      department_id,
      role_id,
      email,
      password: passwordHash,
      phone,
      date_in,
      image
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
    "UPDATE `users` SET `fname`= ?, `lname`= ?, `department_id`= ?, `role_id`= ?, `email`= ?, `phone`= ?, `image`= ? WHERE id = ?",
    [
      req.body.fname,
      req.body.lname,
      req.body.department_id,
      req.body.role_id,
      req.body.email,
      req.body.phone,
      req.body.image,
      req.body.id,

    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/users/updatePassword", async (req, res) => {
  try {
    const { id, password } = req.body
    const passwordHash = await bcrypt.hash(password, 10)
    const [results] = await connection.promise().query('UPDATE users SET password = ? WHERE id = ?', [passwordHash, id])
    res.json({
      message: 'Password updated',
      results
    })
  } catch (error) {
    console.log(error)
    res.json({
      message: 'Password update failed',
      error
    })
  }
})

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

app.get("/api/notebooks/:id", function (req, res, next) {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM `notebooks` WHERE `id` = ?",
    [id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/notebooks/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `notebooks`(`brand`, `model`, `cpu`, `gpu`, `ram`, `storage`, `os`, `asset_number`, `license_window`, `user_id`, `store_id`, `date_in`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
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
      req.body.user_id,
      req.body.store_id,
      req.body.date_in,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/notebooks/update", function (req, res, next) {
  connection.query(
    "UPDATE `notebooks` SET `brand`= ?, `model`= ?, `cpu`= ?, `gpu`= ?, `ram`= ?, `storage`= ?, `os`= ?, `asset_number`= ?, `license_window`= ?, `user_id`= ?, `store_id`= ? WHERE id = ?",
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
      req.body.user_id,
      req.body.store_id,
      req.body.id,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/notebooks/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `notebooks` WHERE id = ?",
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

// equipments -----------------------------------------------------------------------------------------------------------
app.get("/api/equipments", function (req, res, next) {
  connection.query(
    "SELECT * FROM `equipments`",
    function (err, results, fields) {
      res.json(results);
    }
  );
});

app.get("/api/equipments/:id", function (req, res, next) {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM `equipments` WHERE `id` = ?",
    [id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/equipments/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `equipments`(`name`, `location_id`, `user_id`, `store_id` , `asset_number`, `document_number`, `price`, `quantity`, `image`, `date_in`) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [
      req.body.name,
      req.body.location_id,
      req.body.user_id,
      req.body.store_id,
      req.body.asset_number,
      req.body.document_number,
      req.body.price,
      req.body.quantity,
      req.body.image,
      req.body.date_in,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/equipments/update", function (req, res, next) {
  connection.query(
    "UPDATE `equipments` SET `name`= ?, `location_id`= ?, `user_id`= ?, `store_id`= ?, `asset_number`= ?, `document_number`= ?, `price`= ?,`quantity`= ?, `image`= ?, `date_out`= ? WHERE id = ?",
    [
      req.body.name,
      req.body.location_id,
      req.body.user_id,
      req.body.store_id,
      req.body.asset_number,
      req.body.document_number,
      req.body.price,
      req.body.quantity,
      req.body.image,
      req.body.date_out,
      req.body.id,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});
app.delete("/api/equipments/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `equipments` WHERE id = ?",
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

// locations -----------------------------------------------------------------------------------------------------------
app.get("/api/locations", function (req, res, next) {
  connection.query(
    "SELECT * FROM `locations`",
    function (err, results, fields) {
      res.json(results);
    }
  );
});

app.get("/api/locations/:id", function (req, res, next) {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM `locations` WHERE `id` = ?",
    [id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/locations/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `locations`(`id`, `name`, `address`) VALUES (?,?,?)",
    [req.body.id, req.body.name, req.body.address],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/locations/update", function (req, res, next) {
  connection.query(
    "UPDATE `locations` SET `location_name`= ?, `address`= ? WHERE id = ?",
    [
      req.body.name,
      req.body.address,
      req.body.id,
    ],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/locations/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `locations` WHERE id = ?",
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

// departments -----------------------------------------------------------------------------------------------------------
app.get("/api/departments", function (req, res, next) {
  connection.query(
    "SELECT * FROM `departments`",
    function (err, results, fields) {
      res.json(results);
    }
  );
});

app.get("/api/departments/:id", function (req, res, next) {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM `departments` WHERE `id` = ?",
    [id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/departments/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `departments`(`id`, `name`) VALUES (?,?)",
    [req.body.id, req.body.name],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/departments/update", function (req, res, next) {
  connection.query(
    "UPDATE `departments` SET `id`= ?, `name`= ? WHERE id = ?",
    [req.body.id, req.body.name, req.body.id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/departments/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `departments` WHERE id = ?",
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

// stores -----------------------------------------------------------------------------------------------------------
app.get("/api/stores", function (req, res, next) {
  connection.query("SELECT * FROM `stores`", function (err, results, fields) {
    res.json(results);
  });
});

app.get("/api/stores/:id", function (req, res, next) {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM `stores` WHERE `id` = ?",
    [id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/stores/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `stores`(`id`, `name`, `address`) VALUES (?,?,?)",
    [req.body.id, req.body.name, req.body.address],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/stores/update", function (req, res, next) {
  connection.query(
    "UPDATE `stores` SET `name`= ? , `address`= ? WHERE id = ?",
    [req.body.name, req.body.address ,req.body.id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/stores/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `stores` WHERE id = ?",
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

// roles -----------------------------------------------------------------------------------------------------------
app.get("/api/roles", function (req, res, next) {
  connection.query("SELECT * FROM `roles`", function (err, results, fields) {
    res.json(results);
  });
});

app.get("/api/roles/:id", function (req, res, next) {
  const id = req.params.id;
  connection.query(
    "SELECT * FROM `roles` WHERE `id` = ?",
    [id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.post("/api/roles/create", function (req, res, next) {
  connection.query(
    "INSERT INTO `roles`(`id`, `name`) VALUES (?,?)",
    [req.body.id, req.body.name],
    function (err, results) {
      res.json(results);
    }
  );
});

app.put("/api/roles/update", function (req, res, next) {
  connection.query(
    "UPDATE `roles` SET `name`= ? WHERE id = ?",
    [req.body.name, req.body.id],
    function (err, results) {
      res.json(results);
    }
  );
});

app.delete("/api/roles/delete", function (req, res, next) {
  try {
    connection.query(
      "DELETE FROM `roles` WHERE id = ?",
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