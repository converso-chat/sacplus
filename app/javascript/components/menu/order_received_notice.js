import React from "react"
import PropTypes from "prop-types"

// place holder for accept payments card
const OrderReceivedNotice = (props) => {
  let phone = encodeURIComponent(`${props.phoneNumber}`)
  let text = encodeURIComponent(`confirm #${props.orderId}`)

  return(
    <div className="modal fade" id="orderReceivedModal" tabIndex="-1" role="dialog" aria-labelledby="orderReceivedModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
      <div className="modal-dialog modal-dialog-centered" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title" id="orderReceivedModalLabel">Pedido Recebido!</h5>
          </div>
          <div className="modal-body">
            <h1> O código do seu pedido é #{ props.orderId }</h1>
            <span>
              Confirme seu pedido pelo WhatsApp enviando `confirmar #{props.orderId}` para {props.phoneNumber} <br/>
              ou clique no botão para confirmar
            </span>
            <br/>
            <br/>
            <a className='btn btn-primary' href={`https://api.whatsapp.com/send?phone=${phone}&text=${text}`} > Confirmar </a>
          </div>
        </div>
      </div>
    </div>
  )
};

export default OrderReceivedNotice;
