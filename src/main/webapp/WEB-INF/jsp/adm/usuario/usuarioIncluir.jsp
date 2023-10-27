<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body>
<div class="modal fade in" tabindex="-1" role="dialog" id="modal-incluir-usuario">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content p-3">
			<div class="modal-header">
				<h5 class="modal-title nomeTopo">INCLUIR USUÁRIO</h5>
				<button type="button" class="close btn" data-dismiss="modal" aria-label="Close" onclick="fecharModal('modal-incluir-usuario')">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="formPesquisa" id="usuarioIncluir">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-6 col-lg-8">
							<label for="nome"><b>Nome:</b></label> <input id="nome"
								class="form-control validar" type="text" DISABLED/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-4">
							<label for="cpf"><b>CPF:</b></label> <input id="cpf"
								class="form-control validar" type="text" placeholder="Ex 124.356.987-01" onkeyup="verificarPessoa(this.value)"/>
						</div>
						<!-- <div class="col-12 col-sm-12 col-md-6 col-lg-5">
							<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select
								id="tipoPessoa" class="form-select validar">
								<c:forEach items="${dados.DATA.LISTA}" var="t">
									<option value="${t.tip_sigla}">${t.tip_descricao}</option>
								</c:forEach>
							</select>
						</div> -->
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="email"><b>Email:</b></label> <input id="email"
								class="form-control validar" type="text" DISABLED/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="telParticular"><b>Telefone Particular:</b></label> <input id="telParticular"
								class="form-control" type="text" DISABLED/>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="telCorporativo"><b>Telefone Corporativo:</b></label> <input id="telCorporativo"
								class="form-control validar" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="apelido"><b>Apelido:</b></label> <input id="apelido"
								class="form-control validar" type="text" />
						</div>
						<!-- <div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="senha"><b>Senha:</b></label> <input id="senha"
								class="form-control validar" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="senhaConfirmar"><b>Confirmar Senha:</b></label> <input id="senhaConfirmar"
								class="form-control validar" type="text" />
						</div> -->
					</div>
				</form>
			</div>
			<div class="modal-footer">	
				<button type="button" class="btn btn-form" onclick="salvarUsuario()">Continuar <i class="fa fa-arrow-right"></i></button>      
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	$("#usuarioIncluir #cpf").mask("999.999.999-99");
	$("#usuarioIncluir #telParticular").mask("(99) 99999-9999");
	$("#usuarioIncluir #telCorporativo").mask("(99) 99999-9999");
});

function verificarPessoa(value){
	let param = {
			cpf: value
	}
	$.post("${pageContext.request.contextPath}/adm/verificarPessoa", param, function(retorno){
		let obj = JSON.parse(retorno);
		$("#usuarioIncluir #nome").val(obj.DATA.pes_nome);
		$("#usuarioIncluir #email").val(obj.DATA.pes_email);
		$("#usuarioIncluir #telParticular").val(obj.DATA.pes_telefone);

	});	
}
</script>
</body>