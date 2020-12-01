import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../../services/api';
import Input from '../../components/maskphone';

import './styles.css';

function AccessWifi() {

  const [nome, setNome] = useState('');
  const [email, setEmail] = useState('');
  const [whatsapp, setWhatsapp] = useState('');

  const urlUnifi = 'http://192.168.7.234:8880/guest/s/default/?ap=80:2a:a8:a0:94:8a&ec=4C9Y6w_d3b7a75gKNxigaD6hDX2tIB91sinlqVW-bGj_YgkD5an_fIUiRCFV_OBc_EWP5rTER_4N4CiPD7q9LTzmfmVaST-cdyOf8-lnkzVWiy1t2y4L57jeahFSkTa-Y-7rCXptAmHjUQg37e2oAHYAEBhyMNqr9ADeIOyGZKxZcWhmenuoeF2J6CwOU4gL0XT4RAexWXG5V5LxOtUC5w#/';


  function handleHabiDsabi() {
    if (document.getElementById('habi').checked == true) {
      document.getElementById('envia').disabled = '';
    }
    if (document.getElementById('habi').checked == false) {
      document.getElementById('envia').disabled = "disabled";
    }
  }

  async function handleSubmit(e) {
    e.preventDefault();

    const data = {
      nome,
      email,
      whatsapp,
    };
    try {
      const response = await api.post('users', data);

      alert(`Solicitação enviada com sucesso.\nVocê receberá o token de acesso pelo whatsapp.`);
      window.location.href = urlUnifi;

    } catch (error) {
      alert('Erro na solicitação, tente novamente');
    }
  }
  return (
    <div class="container">
      <a class="links" id="parasolicitar"></a>
      <a class="links" id="paratermos"></a>

      <div class="content">

        {/* FORMULÁRIO DE CADASTRO */}
        <div id="cadastro">
          <form onSubmit={handleSubmit}>
            <h1>Solicitação Acesso Wifi</h1>

            <p>
              <label for="nome_cad">Seu nome</label>
              <input
                id="nome_cad"
                name="nome_cad"
                type="text"
                placeholder="Nome"
                value={nome}
                onChange={e => setNome(e.target.value)}
                required
              />
            </p>

            <p>
              <label for="email_cad">Seu e-mail</label>

              <input
                id="email_cad"
                name="email_cad"
                type="email"
                placeholder="contato@htmlecsspro.com"
                value={email}
                onChange={e => setEmail(e.target.value)}
                required
              />

            </p>

            <p>
              <label for="whatsapp_cad">Seu Whatsapp</label>
              <Input
                id="whatsapp_cad"
                mask="(99) 99999-9999"
                name="whatsapp_cad"
                type="text"
                placeholder="(75) 99999-9999"
                value={whatsapp}
                onChange={e => setWhatsapp(e.target.value)}
                required
              />
            </p>

            <p>
              <input type="submit" name="envia" id="envia" value="Solicitar" onclick={handleSubmit} disabled />
            </p>

            <p class="link">
              <input type="checkbox" name="habi" id="habi" onClick={handleHabiDsabi} />
              <label for="manterlogado"> Eu li e aceito os termos de uso</label>

              <Link to={"/termos"} > Termos de uso wifi</Link>
            </p>

          </form>
        </div>

      </div>
    </div>
  );
}

export default AccessWifi;
