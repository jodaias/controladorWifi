import React, { useState } from 'react';
import { Link, useHistory } from 'react-router-dom';
import api from '../../services/api';

function AccessWifi() {
  const [nome, setNome] = useState('');
  const [email, setEmail] = useState('');
  const [whatsapp, setWhatsapp] = useState('');

  const history = useHistory();

  async function handleSubmit(e) {
    e.preventDefault();

    const data = {
      nome,
      email,
      whatsapp,
    };
    try {
      const response = await api.post('users', data);
      alert(`Seu token de acesso é: ${nome}ksjbdf${email}sdfs${whatsapp}`);
      history.push('/');
    } catch (error) {
      alert('Erro na solicitação, tente novamente');
    }
  }

  return (
    <div className="container">
      <h1>Solicitação wifi</h1>

      <p>Faça sua solicitação para acessar o wifi
      </p>

      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Nome"
          value={nome}
          onChange={e => setNome(e.target.value)}
        />

        <input
          type="email"
          placeholder="E-mail"
          value={email}
          onChange={e => setEmail(e.target.value)}
        />

        <input
          type="text"
          placeholder="Whatsapp"
          value={whatsapp}
          onChange={e => setWhatsapp(e.target.value)}
        />
        <button className="button" type="submit">Enviar solicitação</button>
      </form>
    </div>
  );
}

export default AccessWifi;
