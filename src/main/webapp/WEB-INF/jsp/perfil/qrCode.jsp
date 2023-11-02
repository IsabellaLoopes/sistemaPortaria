<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
.modal img{
	width: 40%;
}
</style>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-qrCode">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">QR CODE - ${dados.PARAMETROS.nome}</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-qrCode')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" style="text-align: center;">
				<img src="${pageContext.request.contextPath}/vizualizar/qrCode?qrText=<%= request.getParameter("qrText") %>">
			</div>
		</div>
	</div>
</div>
<script>
</script>
</body>