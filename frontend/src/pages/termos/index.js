import React from 'react';
import { Link } from 'react-router-dom';

import './styles.css';

function TermosWifi() {
  return (
    /* FORMULÁRIO DE SOLICITAÇÃO*/
    <div class="container">

      <div class="content">

        <div id="termos">
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



            <p class="link">
              Voltar para solicitação
              
              <Link to={"/"} > Solicitar Acesso</Link>
            </p>
          </form>
        </div>
      </div>
    </div>
  );
}

export default TermosWifi;
