<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Botón de pago</title></head>
<body>
    <a href="${initPoint}" name="MP-Checkout" class="lightblue-L-Ov" mp-mode="modal">Pagar ${title}</a>

    <script type="text/javascript">
        (function(){function $MPC_load(){window.$MPC_loaded !== true && (function(){var s = document.createElement("script");s.type = "text/javascript";s.async = true;s.src = document.location.protocol+"//secure.mlstatic.com/mptools/render.js";var x = document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);window.$MPC_loaded = true;})();}window.$MPC_loaded !== true ? (window.attachEvent ?window.attachEvent('onload', $MPC_load) : window.addEventListener('load', $MPC_load, false)) : null;})();
    </script>
</body>
</html>