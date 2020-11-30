import React, { useState } from 'react';
import { Link, useHistory } from 'react-router-dom';
import api from '../../services/api';
import Input from '../../components/maskphone';
import './styles.css';



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

      const urlUnifi = 'http://192.168.7.234:8880/guest/s/default/?ap=80:2a:a8:a0:94:8a&ec=4C9Y6w_d3b7a75gKNxigaD6hDX2tIB91sinlqVW-bGj_YgkD5an_fIUiRCFV_OBc_EWP5rTER_4N4CiPD7q9LTzmfmVaST-cdyOf8-lnkzVWiy1t2y4L57jeahFSkTa-Y-7rCXptAmHjUQg37e2oAHYAEBhyMNqr9ADeIOyGZKxZcWhmenuoeF2J6CwOU4gL0XT4RAexWXG5V5LxOtUC5w#/';

      alert(`Solicitação enviada com sucesso.`);
window.open(urlUnifi);
      

      
      history.push('/');
    } catch (error) {
      alert('Erro na solicitação, tente novamente');
    }
  }

  return (

   
      <div class="container">
      
        <a class="links" id="parasolicitar"></a>
        <a class="links" id="paratermos"></a>

        <div class="content">
          {/* FORMULÁRIO DE SOLICITAÇÃO*/}
          <div id="formulario">
            <form method="post" action="">
              <h1>Termos de Uso</h1>

              <h5>
                1.1 Todo usuário que localizar a rede ALCIFMAIS-REUNIAO, deverá acessar e autenticar no serviço,
                        mediante a um cadastro prévio.</h5>
              <h5>
                1.2 Para utilizar basta cadastrar os dados básicos para identificação do cliente exigidos por
                lei para que em necessidades judiciais, policias e ou de investigação, os dados possam levar
                auxiliar nas investigações. Caso concorde com os termos expostos e expresse essa concordância
                por meio do seu cadastro e acesso,seu cadastro será efetuado e
                ALCIFMAIS-REUNIAO para utilizar a internet disponível na sala.

                    </h5>
              <br></br>

              <p>
                <input type="checkbox" name="manterlogado" id="manterlogado" value="" />
                <label for="manterlogado">Concordar</label>
              </p>

              <p class="link">
                Voltar para solicitação
                        <a href="#parasolicitar">Solicitar Acesso</a>
              </p>
            </form>
          </div>

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
                <input type="submit" value="Solicitar" />
              </p>

              <p class="link">
                Leia os termos de uso
                        <a href="#paratermos"> Termos de uso wifi </a>
              </p>
            </form>
          </div>
        </div>
      </div>
  );
}

export default AccessWifi;
