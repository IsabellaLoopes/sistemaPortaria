<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-editar-usuario">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">EDITAR USU�RIO</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-editar-usuario')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="formPesquisa" id="usuarioIncluir">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-6 col-lg-8">
							<label for="nome"><b>Nome:</b></label> <input id="nome"
								class="form-control validar" type="text" value="${dados.DATA.USER.usr_nome}"/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-4">
							<label for="cpf"><b>CPF:</b></label> <input id="cpf"
								class="form-control validar" type="text" placeholder="Ex 124.356.987-01" value="${dados.DATA.USER.usr_cpf}" />
						</div>
						<!-- <div class="col-12 col-sm-12 col-md-6 col-lg-5">
							<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select
								id="tipoPessoa" class="form-select validar">
								<c:forEach items="${dados.DATA.LISTA}" var="t">
									<option value="${t.tip_sigla}" <c:if test="${dados.DATA.USER.usr_tipo == t.tip_sigla}">SELECTED</c:if>>${t.tip_descricao}</option>
								</c:forEach>
							</select>
						</div> -->
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="email"><b>Email:</b></label> <input id="email"
								class="form-control validar" type="text" value="${dados.DATA.USER.usr_email}"/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="telParticular"><b>Telefone Particular:</b></label> <input id="telParticular"
								class="form-control" type="text" value="${dados.DATA.USER.usr_telParticular}"/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="telCorporativo"><b>Telefone Corporativo:</b></label> <input id="telCorporativo"
								class="form-control" type="text" value="${dados.DATA.USER.usr_telCorporativa}"/>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarUsuario(${dados.DATA.USER.usr_id})">Confirmar <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#usuarioIncluir #cpf").mask("999.999.999-99");
});
</script>
</body>