<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-incluir-permissao">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">INCLUIR PERMISSÃO</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-incluir-permissao')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="formPesquisa" id="permissaoIncluir">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-6 col-lg-5">
							<label for="cadastrarPor"><b>Cadastrar por:</b></label> <select
								id="cadastrarPor" class="form-select validar" onchange="mudarTipo()">
									<option value="1">Tipo Pessoa</option>
									<option value="2">Pessoa</option>
							</select>
						</div>
						<div class="col-12 col-sm-12 col-md-12 col-lg-12">
							<label for="aparelho"><b>Aparelho:</b></label> <select
								id="aparelho" class="form-select validar">
								<option value="0">Selecione...</option>
								<c:forEach items="${dados.DATA.APARELHO}" var="t">
									<option value="${t.apa_id}">${t.apa_descricao}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-12 col-md-12 col-lg-12 tipoPessoa">
							<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select
								id="tipoPessoa" class="form-select">
									<option value="0">Selecione...</option>
								<c:forEach items="${dados.DATA.TIPO}" var="t">
									<option value="${t.tip_id}">${t.tip_descricao}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-12 col-md-12 col-lg-12 pessoa">
							<label for="pessoa"><b>Pessoa:</b></label> <select
								id="pessoa" class="form-select">
									<option value="0">Selecione...</option>
								<c:forEach items="${dados.DATA.PESSOA}" var="t">
									<option value="${t.pes_id}">${t.pes_nome}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarPermissao()">Continuar <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	mudarTipo()
});

function mudarTipo(){
	$("#permissaoIncluir .tipoPessoa").addClass("d-none");
	$("#permissaoIncluir .pessoa").addClass("d-none");
	
	$("#permissaoIncluir #tipoPessoa").val(0);
	$("#permissaoIncluir #pessoa").val(0);
	
	let tipo = parseInt($("#permissaoIncluir #cadastrarPor").val());
	if(tipo == 1){
		$("#permissaoIncluir #pessoa").removeClass("validar");
		$("#permissaoIncluir .tipoPessoa").removeClass("d-none");
		$("#permissaoIncluir #tipoPessoa").addClass("validar");
	} else if(tipo == 2){
		$("#permissaoIncluir #tipoPessoa").removeClass("validar");
		$("#permissaoIncluir .pessoa").removeClass("d-none");
		$("#permissaoIncluir #pessoa").addClass("validar");
	}
}
</script>
</body>