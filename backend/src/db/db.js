const mysql = require("mysql2/promise");

async function connect() {
  if (global.connection && global.connection.state !== 'disconnected')
    return global.connection;

  const connection = await mysql.createConnection("mysql://root:@localhost:3306/WifiAccess");
  console.log("Conectou no MySQL!");
  global.connection = connection;
  return connection;
}

async function selectUsers() {
  const conn = await connect();
  const [rows] = await conn.query('SELECT * FROM users;');
  return rows;
}

async function selectUser(email) {
  const conn = await connect();
  const sql = 'SELECT id, nome, email, whatsapp FROM users  where email=?;';
  const [row] = await conn.query(sql, [email]);
  return row;
}

async function insertUser(user) {
  console.log('aqui passou 32');
  const conn = await connect();
  const sql = 'INSERT INTO users(nome,email,whatsapp) VALUES (?,?,?);';
  const values = [user.nome, user.email, user.whatsapp];

  return await conn.query(sql, values);
}

async function updateUser(email, user) {
  const conn = await connect();

  const user1 = await selectUser(email);

  const sql = 'UPDATE users SET nome=?, email=?, whatsapp=? WHERE email=?';
  const values = [user.nome, user.email, user.whatsapp, email];

  return await conn.query(sql, values);
}

async function deleteUser(id) {
  const conn = await connect();
  const sql = 'DELETE FROM users where id=?;';
  return await conn.query(sql, [id]);
}

module.exports = { selectUsers, insertUser, updateUser, deleteUser, selectUser }