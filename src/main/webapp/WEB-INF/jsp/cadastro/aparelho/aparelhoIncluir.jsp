<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-incluir-aparelho">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">INCLUIR APARELHO</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-incluir-usuario')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="formPesquisa" id="aparelhoIncluir">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-6 col-lg-8">
							<label for="descricao"><b>Descrição:</b></label> <input id="descricao"
								class="form-control validar" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-4">
							<label for="ip"><b>IP:</b></label> <input id="ip"
								class="form-control validar" type="text" placeholder="Ex 192.168.000.001"/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-5">
							<label for="tipoOperacao"><b>Tipo Operação:</b></label> <select
								id="tipoOperacao" class="form-select validar">
								<c:forEach items="${dados.DATA.LISTA}" var="t">
									<option value="${t.tip_sigla}">${t.tip_descricao}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarAparelho()">Continuar <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#aparelhoIncluir #ip").mask("999.999.999.999");
});
</script>
</body>