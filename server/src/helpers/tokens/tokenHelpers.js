const sendJwtToClient = (user, response) => {
  const token = user.generateJwtFromUser();
  const { JWT_COOKIE, NODE_ENV } = process.env;
  return response
    .status(200)
    .cookie("access_token", token, {
      httpOnly: true,
      expires: new Date(Date.now() + parseInt(JWT_COOKIE) * 1000),
      secure: NODE_ENV === "development" ? false : true,
    })
    .json({
      success: true,
      access_token: token,
      data: {
        name: user.name,
        surname: user.surname,
        email: user.email,
        id: user.id,
        address: user.address,
      },
    });
};
const isTokenIncluded = (req) => {
  if (
    !req.headers.authorization ||
    !req.headers.authorization.startsWith("Bearer") ||
    !req.headers.authorization.split(" ")[1]
  ) {
    return { err: true, token: "" };
  }
  const theToken = req.headers.authorization.split(" ")[1];
  return { err: false, token: theToken };
};

module.exports = { sendJwtToClient, isTokenIncluded };
