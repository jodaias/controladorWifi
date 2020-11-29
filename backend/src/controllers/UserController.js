const db = require("../db/db");
//const fs = require("fs");
//var jwt = require('jsonwebtoken');

const validations = require("./validations");

(async () => {
  console.log('Começou!');
})();

module.exports = {

  //cadastro de usuário
  async create(request, response) {


    const { nome, email, whatsapp } = request.body;

    const val1 = validations.userSchema.validate({ nome, whatsapp, email });
    console.log("Passou na validação: " + !val1.error);

    if (!val1.error) {

      console.log('INSERT INTO USERS');

      //verifica se o usuario existe no banco de dados

      const user = await db.selectUser(email);

      if (user[0] == undefined) {
      

        const result = await db.insertUser({ nome, email, whatsapp });
        console.log(`criou o cadastro`);

        return response.json(result);
      } else {
        
        const result1 = await db.updateUser(email, { nome, email, whatsapp });
        console.log(`Atualizou o cadastro`);

        return response.json(result1);
      }

    }

    return response.json(val1.error);
  },

  //Listar todos os usuários
  async index(request, response) {
    console.log('SELECT * FROM USERS');

    const users = await db.selectUsers();
    console.log(users);

    return response.json(users);
  },

  //Deletar um relatório
  async delete(request, response) {
    const { id } = request.params;

    console.log('DELETE USERS');
    const result3 = await db.deleteUser(id);
    console.log(result3);
    return response.status(204).json(result3);
  },

  //Editar um usuário
  async edit(request, response) {
    const { id } = request.params;

    const { nome, email, whatsapp } = request.body;

    const val1 = validations.userSchema.validate({ nome, whatsapp, email });
    console.log("Passou na validação: " + !val1.error);

    const id_Header = request.headers.authorization;

    const user = await db.selectUser(email);

    if (user[0].id != id_Header) {
      console.log(user[0].id);

      return response.status(401).json({ error: 'Operation not permitted.' });
    }
    console.log('UPDATE USERS');
    if (!val1.error) {

      const result2 = await db.updateUser(email, { nome, email, whatsapp });

      return response.status(204).json(result2);
    }

    return response.status(400).json(val1.error);
  },

}