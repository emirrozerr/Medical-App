const emailCheck = (req, res, next) => {
  const emailRegexp =
    /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
  if (emailRegexp.test(req.body.email)) {
    next();
  } else {
    res.status(401).send({ success: false, msg: "Lütfen mail adresini kontrol ediniz" });
  }
};

const passwordCheck = (req, res, next) => {
  if (req.body.password.length >= 6) {
    next();
  } else {
    res.status(401).send({ success: false, msg: "Şifreyi kontrol ediniz." });
  }
};
const nameAndSurnameCheck = (req, res, next) => {
  if (req.body.name.length > 0 && req.body.surname.length > 0) {
    next();
  } else {
    res.status(401).send({ success: false, msg: "Ad veya soyadı kontrol ediniz." });
  }
};

module.exports = {
  nameAndSurnameCheck,
  passwordCheck,
  emailCheck,
};
