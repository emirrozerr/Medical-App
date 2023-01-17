const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { db } = require("../../helpers/database/dbConnection");
const { isTokenIncluded } = require("../../helpers/tokens/tokenHelpers");

const registerDoctor = (req, res, next) => {
  db.query(
    `SELECT * FROM doctors WHERE LOWER(email) = LOWER(${db.escape(
      req.body.email
    )});`,

    (err, result) => {
      if (result.length) {
        return res.status(409).send({
          success: false,
          msg: "Bu mail adresi zaten kullanılıyor.",
        });
      } else {
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          if (err) {
            return res.status(500).send({
              success: false,
              msg: err,
            });
          } else {
            db.query(
              `INSERT INTO doctors (name, surname, phone, email, password, image, is_doctor,school,hospital,major,professions) VALUES ('${
                req.body.name
              }','${req.body.surname}','${req.body.phone}',${db.escape(
                req.body.email
              )}, ${db.escape(hash)},'default.png'), ${db.escape( 1 )}, ${db.escape( req.body.school )}, ${db.escape( req.body.hospital )}, ${db.escape( req.body.major )}, ${db.escape( req.body.professions )}`,
              (err, result) => {
                if (err) {
                  throw err;
                  return res.status(400).send({
                    success: false,
                    msg: err,
                  });
                }
                return res.status(201).send({
                  success: true,
                  msg: "Kayıt başarılı giriş yapabilirsiniz.",
                });
              }
            );
          }
        });
      }
    }
  );
};


const register = (req, res, next) => {
  db.query(
    `SELECT * FROM users WHERE LOWER(email) = LOWER(${db.escape(
      req.body.email
    )});`,
    (err, result) => {
      if (result.length) {
        return res.status(409).send({
          success: false,
          msg: "Bu mail adresi zaten kullanılıyor.",
        });
      } else {
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          if (err) {
            return res.status(500).send({
              success: false,
              msg: err,
            });
          } else {
            db.query(
              `INSERT INTO users (name, surname, phone, email, password, image) VALUES ('${
                req.body.name
              }','${req.body.surname}','${req.body.phone}',${db.escape(
                req.body.email
              )}, ${db.escape(hash)},'default.png')`,
              (err, result) => {
                if (err) {
                  throw err;
                  return res.status(400).send({
                    success: false,
                    msg: err,
                  });
                }
                return res.status(201).send({
                  success: true,
                  msg: "Kayıt başarılı giriş yapabilirsiniz.",
                });
              }
            );
          }
        });
      }
    }
  );
};
const login = (req, res, next) => {
  const { JWT_SECRET, JWT_TIME } = process.env;
  db.query(
    `SELECT * FROM users WHERE email = ${db.escape(req.body.email)};`,
    (err, result) => {
      if (err) {
        throw err;
        return res.status(400).send({
          success: false,
          msg: err,
        });
      }
      if (!result.length) {
        return res.status(401).send({
          success: false,
          msg: "Email veya şifre yanlış!",
        });
      }
      bcrypt.compare(
        req.body.password,
        result[0]["password"],
        (bErr, bResult) => {
          if (bErr) {
            throw bErr;
            return res.status(401).send({
              success: false,
              msg: "Email veya şifre yanlış!",
            });
          }
          if (bResult) {
            const token = jwt.sign(
              { id: result[0].id, email: result[0].email },
              JWT_SECRET,
              {
                expiresIn: JWT_TIME,
              }
            );
            db.query(
              `UPDATE users SET last_login = now() WHERE id = '${result[0].id}'`
            );

            return res.status(200).send({
              msg: "kayıt başarılı",
              success: true,
              token,
              user: result[0],
            });
          }
          return res.status(401).send({
            success: false,
            msg: "Email veya şifre yanlış!",
          });
        }
      );
    }
  );
};

const getUser = (req, res, next) => {
  const { JWT_SECRET } = process.env;
  let control = isTokenIncluded(req);
  if (control.err) {
    res.status(400).send("Token çalışmıyor");
    return;
  }

  const decoded = jwt.verify(control.token, JWT_SECRET);

  db.query(
    "SELECT * FROM users where id=?",
    decoded.id,
    function (error, results, fields) {
      if (error) throw error;
      return res.send({
        error: false,
        user1: results[0],
        message: "İşlem Başarılı",
      });
    }
  );
};

const uploadImage = (req, res, next) => {
  const { JWT_SECRET } = process.env;
  let control = isTokenIncluded(req);
  if (control.err) {
    res.status(400).send("Token çalışmıyor");
    return;
  }

  const decoded = jwt.verify(control.token, JWT_SECRET);

  if (!req.files || Object.keys(req.files).length === 0) {
    res.status(400).send("Hiç Dosya bulunamadı");
    return;
  }
  const file = req.files.file;

  file.mv(
    `${__dirname}/../../../public/uploads/${decoded.id}-${file.name}`,
    async (err) => {
      if (err) {
        console.error(err);
        return res.status(500).send(err);
      }
    }
  );
  db.query(
    `UPDATE users SET image="${decoded.id}-${file.name}" where id=${decoded.id}`,
    (err, result) => {
      if (err) {
        throw err;
        return res.status(400).send({
          success: false,
          msg: err,
        });
      }
      db.query(`SELECT * FROM users WHERE id=${decoded.id}`, (err, result) => {
        if (err) {
          throw err;
          return res.status(400).send({
            success: false,
            msg: err,
          });
        }
        return res.status(200).send({
          success: true,
          user: result,
          msg: "Resim başarıyla güncellendi",
          token: control.token,
        });
      });
    }
  );
};

const getDoctor = (req, res, next) => {
  const { uname } = req.params;

  if (uname === undefined) {
    return res.status(400).send({
      success: false,
      msg: "uname not null",
    });
  } else {
    db.query(
      `SELECT u.name, u.id, u.surname, u.image, m.science from users as u JOIN major_science as m on u.major = m.id  WHERE u.name like '${uname}%' and is_doctor = 1`,
      (err, result) => {
        if (err) {
          throw err;
          return res.status(400).send({
            success: false,
            msg: err,
            body: [],
          });
        } else if (result.length <= 0) {
          return res.status(400).send({
            success: false,
            msg: "Doctor Yok",
            body: [],
          });
        }
        return res.status(200).send({
          success: true,
          body: result,
          msg: "Doctorlar geldi",
        });
      }
    );
  }
};

const getDoctorA = (req, res, next) => {
  const { id } = req.params;
  if (id === undefined) {
    return res.status(400).send({
      success: false,
      msg: "uname not null",
    });
  } else {
    db.query(
      `SELECT u.name, u.id, u.surname, u.image, m.science from users as u JOIN major_science as m on u.major = m.id  WHERE u.profession like '%${id}%' and is_doctor = 1`,
      (err, result) => {
        if (err) {
          throw err;
          return res.status(400).send({
            success: false,
            msg: err,
            body: [],
          });
        } else if (result.length <= 0) {
          return res.status(400).send({
            success: false,
            msg: "Doctor Yok",
            body: [],
          });
        }
        return res.status(200).send({
          success: true,
          body: result,
          msg: "Doctorlar geldi",
        });
      }
    );
  }
};
const getDoctorB = (req, res, next) => {
  const { id } = req.params;

  if (id === undefined) {
    return res.status(400).send({
      success: false,
      msg: "id not null",
    });
  } else {
    db.query(
      `SELECT u.name, u.id, u.surname, u.image, m.science from users as u JOIN major_science as m on u.major = m.id  WHERE m.science = '${id}' and is_doctor = 1`,
      (err, result) => {
        if (err) {
          throw err;
          return res.status(400).send({
            success: false,
            msg: err,
            body: [],
          });
        } else if (result.length <= 0) {
          return res.status(400).send({
            success: false,
            msg: "Doctor Yok",
            body: [],
          });
        }
        return res.status(200).send({
          success: true,
          body: result,
          msg: "Doctorlar geldi",
        });
      }
    );
  }
};

const getMajorList = (req, res, next) => {
  db.query(`SELECT * from major_science`, (err, result) => {
    if (err) {
      throw err;
      return res.status(400).send({
        success: false,
        msg: err,
        body: [],
      });
    } else if (result.length <= 0) {
      return res.status(400).send({
        success: false,
        msg: "Doctor Yok",
        body: [],
      });
    }
    return res.status(200).send({
      success: true,
      body: result,
      msg: "Doctorlar geldi",
    });
  });
};
module.exports = {
  uploadImage,
  getUser,
  register,
  login,
  getDoctor,
  getDoctorA,
  getDoctorB,
  getMajorList,
  registerDoctor,
};
