const express = require('express');

const UserController = require('./controllers/UserController');

const routes = express.Router();

//Cadastros de usuários
routes.post('/users', UserController.create);
//Listar  todos os usuários
routes.get('/users', UserController.index);
//Editar um usuário
routes.put('/users/:id', UserController.edit);
//Deletar um usuário
routes.delete('/users/:id', UserController.delete);

module.exports = routes;