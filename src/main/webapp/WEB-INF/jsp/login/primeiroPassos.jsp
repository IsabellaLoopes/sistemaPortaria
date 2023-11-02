<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="utf-8" />
<tiles:insertDefinition name="login">

	<tiles:putAttribute name="body">
		<div id="modal-primeiros-passos" class="modal fade">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="row">
						<div class="col-12 col-sm-12 col-md-7 col-lg-7">
							<img src="${pageContext.request.contextPath}/img/seguranca.png"/>
						</div>
						<div class="col-12 col-sm-12 col-md-5 col-lg-5 bgColor-primary" style="border-radius:0 50px 50px 0 !important">
							<div style="width:80%; margin:10%; margin-top:30%">
								<h1 class="mt-3">Ficou mais fácil manter o controle com ACESSO SEGURO</h1>
								<p id="p-login">Seja bem-vindo(a) ao ACESSO SEGURO.<br>Mantenha o controle 
													do fluxo de pessoas em seu ambiente empresarial em tempo 
														real.</p>
								<button type="button" class="btn btn-primary btn-primeirosPassos color-primary" onclick="fecharModal('modal-primeiros-passos')">Continuar <i class="fa fa-arrow-right"></i></button>
							</div>
							<img style="width:40%; float: right; margin:10%; opacity:0.5" src="${pageContext.request.contextPath}/img/logo-letra-branca-transparente.png"/>
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>

	<tiles:putAttribute name="footer">
		<script>
			$(document).ready(function () {
				sessionStorage.setItem("loginId", ${dados.PARAMETROS.usr_id});
				sessionStorage.setItem("qrText", `${dados.PARAMETROS.usr_id}` + '/' + `${dados.PARAMETROS.usr_cpf}`);
				sessionStorage.setItem("pessoaId", ${dados.PARAMETROS.pes_id});
				
				if(${dados.PARAMETROS.primeiroAcesso == 'S'}){
					$("#modal-primeiros-passos").modal("show");
			    	
			    	$('#modal-primeiros-passos').on('hidden.bs.modal', function (e) {
			    		paginaPrincipal({usuario: ${dados.PARAMETROS.usr_id}})
			    	});
				} else{
					paginaPrincipal({usuario: ${dados.PARAMETROS.usr_id}})
				}
		    	
			})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>