const jwt = require("jsonwebtoken");
const { db } = require("../../helpers/database/dbConnection");
const {
  getUserbyIDMessage,
  makeQueryString,
} = require("../../helpers/messages");
const { isTokenIncluded } = require("../../helpers/tokens/tokenHelpers");

const getUserAllMessage = async (req, res, next) => {
  const { JWT_SECRET } = process.env;
  let control = isTokenIncluded(req);
  if (control.err) {
    res.status(400).send("Token çalışmıyor");
    return;
  }

  const id = req.headers.id;
  if (id === undefined) {
    return res.status(400).send({
      success: false,
      msg: "id yok",
      body: [],
    });
  }
  const a = `SELECT * FROM ((SELECT id,duo  FROM message WHERE message.target = ${id}  GROUP BY message.duo) UNION (SELECT id,duo  FROM message WHERE message.source = ${id}  GROUP BY message.duo)) as b GROUP BY duo ORDER BY id`;

  db.query(a, (err, result) => {
    if (err) {
      throw err;
      return res.status(400).send({
        success: false,
        msg: err,
        body: [],
      });
    }
    if (result.length <= 0) {
      return res.status(400).send({
        success: false,
        msg: "Mesaj yok",
        body: [],
      });
    }
    let a = [];
    result.map((e) => {
      a.push(getUserbyIDMessage(e.duo, id));
    });

    let str = makeQueryString(a);
    db.query(str, (err, result2) => {
      if (err) {
        throw err;
        return res.status(400).send({
          success: false,
          msg: err,
          body: [],
        });
      }
      result.map((item, index) => {
        item.source = id;
        item.target = a[index];
        item.name = result2[index].name;
        item.surname = result2[index].surname;
        item.image = result2[index].image;
        item.last_login = result2[index].last_login;
        item.science = result2[index].science;

        return item;
      });

      return res.status(200).send({
        success: true,
        msg: "err",
        body: result,
      });
    });
  });
};

const sendMessage = async (req, res, next) => {
  const { target, source, message } = req.headers;

  const str = [source, target].sort().join("-");

  db.query(
    `INSERT INTO message (target, source, message, duo) VALUES (${Number(
      target
    )},${Number(source)},'${message}','${str}')`,
    (err, result) => {
      if (err) {
        console.log(target, source, message);
        throw err;
        return res.status(400).send({
          success: false,
          msg: err,
        });
      }

      return res.status(200).send({
        success: true,
        msg: "",
      });
    }
  );
};
const messageDetails = async (req, res, next) => {
  const { duo } = req.headers;
  const a = `select * from message WHERE duo = "${duo}"`;
  console.log(a);
  db.query(a, (err, result) => {
    if (err) {
      throw err;
      return res.status(400).send({
        success: false,
        msg: err,
      });
    }
    console.log(result);
    return res.status(200).send(result);
  });
};

module.exports = {
  getUserAllMessage,
  messageDetails,
  sendMessage,
};
