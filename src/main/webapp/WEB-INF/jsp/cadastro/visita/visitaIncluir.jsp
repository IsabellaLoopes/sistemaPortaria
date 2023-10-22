<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-incluir-visita">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">INCLUIR VISITA</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-incluir-visita')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="formPesquisa" id="visitaIncluir">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-5 col-lg-4">
							<label for="cpf"><b>CPF:</b></label> <input id="cpf"
								class="form-control validar" type="text" placeholder="Ex 124.356.987-01"/>
						</div>
						<div class="col-12 col-sm-12 col-md-3 col-lg-3">
							<label for="dataExpiracao"><b>Data Expiração:</b></label> <input id="dataExpiracao"
								class="form-control validar" type="datetime-local" value="${dataHora}"/>
						</div>
						<div class="col-12 col-sm-12 col-md-5 col-lg-5">
							<label for="responsavel"><b>Responsável:</b></label> <input id="responsavel"
								class="form-control validar" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-4 col-lg-4">
							<label for="observacao"><b>Observações:</b></label> <input id="observacao"
								class="form-control" type="text" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarVisita()">Incluir <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#visitaIncluir #cpf").mask("999.999.999-99");
})
</script>
</body>