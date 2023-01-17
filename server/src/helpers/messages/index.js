const getUserbyIDMessage = (str, id) => {
  let arr = str.split("-").map(Number);
  if (arr.indexOf(Number(id)) > -1) {
    arr.splice(arr.indexOf(Number(id)), 1);
  }
  return arr[0];
};

const makeQueryString = (a) => {
  let str = "select u.id,u.image,u.name,u.email,u.surname,u.phone,u.last_login,major_science.science from users as u JOIN major_science on u.major = major_science.id where ";

  for (let ct = 0; ct < a.length; ct++) {
    if (a.length == 1 && ct == 0) {
      str += "u.id = " + a[ct];
    } else if (ct === a.length - 1) {
      str += "u.id = " + a[ct];
    } else {
      str += "u.id = " + a[ct] + " or ";
    }
  }

  return str;
};


module.exports = {
  getUserbyIDMessage,
  makeQueryString,
};
