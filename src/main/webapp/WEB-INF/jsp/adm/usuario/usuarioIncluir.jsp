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
								class="form-control" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-4">
							<label for="cpf"><b>CPF:</b></label> <input id="cpf"
								class="form-control" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-5">
							<label for="tipoPessoa"><b>Tipo Pessoa:</b></label> <select
								id="tipoPessoa" class="form-select">
								<c:forEach items="${dados.DATA.LISTA}" var="t">
									<option value="${t.tip_sigla}">${t.tip_descricao}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-7">
							<label for="email"><b>Email:</b></label> <input id="email"
								class="form-control" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="telParticular"><b>Telefone Particular:</b></label> <input id="telParticular"
								class="form-control" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="telCorporativo"><b>Telefone Corporativo:</b></label> <input id="telCorporativo"
								class="form-control" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="senha"><b>Senha:</b></label> <input id="senha"
								class="form-control" type="text" />
						</div>
						<div class="col-12 col-sm-12 col-md-6 col-lg-6">
							<label for="senhaConfirmar"><b>Confirmar Senha:</b></label> <input id="senhaConfirmar"
								class="form-control" type="text" />
						</div>
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
function geraMetas(){
	var param = {
		ano : gerarMetas.ano.value,
		mes : gerarMetas.mes.value,
		chave : gerarMetas.chave.value,
		vendedor : gerarMetas.vendedor.value,
		percentual : gerarMetas.percentual.value,
		agrupamento: gerarMetas.agrupamento.value,
		oper: gerarMetas.oper.value
		
	};
	$.post('${pageContext.request.contextPath}/comercial/gerarMetas.do', param).success(function(data) {
		// ATUALIZA ATIVO NA TELA
		if (data == 0) {
			mensagem("sucesso", "Metas geradas com sucesso!!!");
			$("#modal-gerarMetas").modal("hide")
			listar();
		} else {
			mensagem("erro", "Ocorreu ao gerar metas!!!");
		}
	}).error(function(){
		Swal.fire('', 'Erro ao processar Dados!!!', 'error')
	});
}

function salvarUsuario(){
	let param = {
			nome: $("#usuarioIncluir #nome").val(),
			cpf: $("#usuarioIncluir #cpf").val(),
			tipoPessoa: $("#usuarioIncluir #tipoPessoa").val(),
			email: $("#usuarioIncluir #email").val(),
			telParticular: $("#usuarioIncluir #telParticular").val(),
			telCorporativo: $("#usuarioIncluir #telCorporativo").val(),
			senha: $("#usuarioIncluir #senha").val(),
			senhaConfirmar: $("#usuarioIncluir #senhaConfirmar").val()
	}
	
	$.post("${pageContext.request.contextPath}/adm/usuarioSalvar", param, function(retorno){
		let obj = JSON.parse(retorno);
		
		if(obj.DATA.erro == 0){
			$("#modal-incluir-usuario").modal("hide");
			Swal.fire({
				  title: 'Sucesso!',
				  text: obj.DATA.mensagem,
				  icon: 'success',
				  confirmButtonText: 'Ok'
				})
			pesquisarUsuario()
		} else{
			Swal.fire({
				  title: 'Ops!',
				  text: obj.DATA.mensagem,
				  icon: 'error',
				  confirmButtonText: 'Ok'
				})
		}
	});
}
</script>
</body>