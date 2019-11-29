<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Pago Custom por API</title>
    <script type="text/javascript" src="https://secure.mlstatic.com/sdk/javascript/v1/mercadopago.js"></script>
</head>
<body>
    <form action="/payment/custom" method="post" id="pay" name="pay" >
        <fieldset>
            <ul>
                <li>
                    <label for="amount">Monto a Pagar:</label>
                    <input type="number" id="amount" name="amount"></input>
                </li>
                <li>
                    <label for="docType">Tipo de Documento:</label>
                    <select id="docType" data-checkout="docType"></select>
                </li>
                <li>
                    <label for="docNumber">Número de Documento:</label>
                    <input type="number" id="docNumber" data-checkout="docNumber" placeholder="12345678"/>
                </li>
                <li>
                    <label for="email">Email</label>
                    <input id="email" name="email" type="email" placeholder="Tu dirección de correo"/>
                </li>
                <li>
                    <label for="cardholderName">Nombre completo (como aparece en la tarjeta):</label>
                    <input type="text" id="cardholderName" data-checkout="cardholderName" placeholder="John Doe" />
                </li>
                <li>
                    <label for="cardNumber">Número de la tarjeta:</label>
                    <input type="number" id="cardNumber" data-checkout="cardNumber" placeholder="4509 9535 6623 3704" onselectstart="return false" onpaste="return false" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete=off />
                </li>
                <li>
                    <label for="securityCode">Código de seguridad:</label>
                    <input type="number" id="securityCode" data-checkout="securityCode" placeholder="123" onselectstart="return false" onpaste="return false" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete=off />
                </li>
                <li>
                    <label for="cardExpirationMonth">Mes Vencimiento:</label>
                    <input type="number" id="cardExpirationMonth" data-checkout="cardExpirationMonth" placeholder="12" onselectstart="return false" onpaste="return false" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete=off />
                </li>
                <li>
                    <label for="cardExpirationYear">Año Vencimiento:</label>
                    <input type="number" id="cardExpirationYear" data-checkout="cardExpirationYear" placeholder="2015" onselectstart="return false" onpaste="return false" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" autocomplete=off />
                </li>
                <li>
                    <label for="issuer">Emisor:</label>
                    <select id="issuer" name="issuer"></select>
                </li>
                <li>
                    <label for="installments">Cuotas:</label>
                    <select id="installments" name="installments"></select>
                </li>
            </ul>
            <input id="paymentMethodId" type="hidden" name="paymentMethodId" />
            <input id="token" type="hidden" name="token" />
            <input type="submit" value="Pagar" />
        </fieldset>
    </form>

    <script type="text/javascript">
        window.Mercadopago.setPublishableKey("TEST-e46802a1-04e6-460d-b19b-98dc7d1af24c");
        window.Mercadopago.getIdentificationTypes();

        document.getElementById('pay').addEventListener('submit', doPay);
        document.getElementById('cardNumber').addEventListener('change', getPaymentMethod);
        document.getElementById('issuer').addEventListener('change', getInstallments);

        function getBin() {
            const element = document.getElementById("cardNumber").value;
            return element.substring(0,6);
        }

        function getPaymentMethod() {
            const bin = getBin();
            if (bin.length >= 6) {
                window.Mercadopago.getPaymentMethod({
                    "bin": bin
                }, setPaymentMethod);
            }
        }

        function setPaymentMethod(status, response) {
            if (status == 200) {
                const element = document.getElementById('paymentMethodId');
                element.value = response[0].id;

                window.Mercadopago.getIssuers(element.value, setIssuers);
            } else {
                alert(`payment method info error: ${response}`);
            }
        }

        function setIssuers(status, response) {
            if (status == 200) {
                document.getElementById('issuer').options.length = 0;
                response.forEach( issuer => {
                    let opt = document.createElement('option');
                    opt.text = issuer.name;
                    opt.value = issuer.id;
                    document.getElementById('issuer').appendChild(opt);
                });
                getInstallments();
            } else {
                alert(`issuers method info error: ${response}`);
            }
        }

        function getInstallments(){
            window.Mercadopago.getInstallments({
                "payment_method_id": document.getElementById('paymentMethodId').value,
                "amount": parseFloat(document.getElementById('amount').value),
                "issuer_id": parseInt(document.getElementById('issuer').value)
            }, setInstallments);
        }

        function setInstallments(status, response) {
            if (status == 200) {
                document.getElementById('installments').options.length = 0;
                response[0].payer_costs.forEach( installment => {
                    let opt = document.createElement('option');
                    opt.text = installment.recommended_message;
                    opt.value = installment.installments;
                    document.getElementById('installments').appendChild(opt);
                });
            } else {
                alert(`installments method info error: ${response}`);
            }
        }

        function doPay(event){
            event.preventDefault();
            const form = document.getElementById('pay');
            window.Mercadopago.createToken(form, setToken);
        }

        function setToken(status, response) {
            if (status != 200 && status != 201) {
                alert("verify filled data");
            } else {
                let token = document.getElementById('token');
                token.value = response.id;
                document.getElementById('pay').submit();
            }
        }

    </script>
</body>
</html>