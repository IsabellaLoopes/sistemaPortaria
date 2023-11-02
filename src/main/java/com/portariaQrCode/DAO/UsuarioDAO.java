package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;
import com.portariaQrCode.util.Criptografia;

public class UsuarioDAO {
	private DAO dao;
	
	public UsuarioDAO(DAO dao) {
		this.dao = dao;
	}

	public List<Registro> listarTipoPessoa(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarTipoPessoa @status=?", 
				new Object[] {param.getAsStringOrValue("status", "")});
	}

	public Registro salvarUsuario(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.salvarUsuario @id=?, @nome=?, @tipo=?, @email=?, @telParticular=?, @telCorporativo=?, @senha=?, @status=?, @cpf=?, @cnpj=?, @apelido=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("nome"), param.getAsString("tipoPessoa"), 
						param.getAsString("email"), param.getAsString("telParticular"), param.getAsString("telCorporativo"), 
						param.getAsIntOrZero("id") <= 0 ? Criptografia.encripta(param.getAsString("senha")) : "", param.getAsStringOrValue("status", "S"), param.getAsString("cpf"),
						param.getAsStringOrValue("cnpj", ""), param.getAsString("apelido")});
	}
	
	public List<Registro> listarUsuario(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarUsuario @nome=?, @tipo=?, @status=?, @cpf=?, @id=?", 
				new Object[] {param.getAsStringOrValue("nome", ""), param.getAsStringOrValue("tipo", ""),
						param.getAsStringOrValue("status", ""), param.getAsStringOrValue("cpf", ""), 
						param.getAsIntOrZero("id")});
	}
	
	public Registro alteraStatusUsuario(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.alteraStatusUsuario @id=?, @status=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("status")});
	}
	
	public Registro verificarLoginWeb(Registro param) {
		return dao.getRowAsRegistro("EXEC sistema.verificarLoginWeb @login=?, @senha=?",
				new Object[] {param.getAsString("login"), Criptografia.encripta(param.getAsString("senha"))});
	}
	
	public List<Registro> menuUsuario(Registro param) {
		return dao.listaRowAsRegistro("EXEC sistema.listarMenuUsuario @nivel=?, @status=?, @usuario=?", 
				new Object[] {param.getAsIntOrValue("nivel", -1), param.getAsStringOrValue("status", "S"),
						param.getAsIntOrValue("loginId", param.getAsIntOrZero("usuario"))});
	}
	
	public Registro verificarPessoa(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.verificarPessoa @cpf=?",
				new Object[] {param.getAsStringOrValue("cpf", "")});
	}
	
	public Registro verificarUsuarioSenha(Registro param) {
		return dao.getRowAsRegistro("EXEC sistema.verificarUsuarioSenha @usuario=?, @email=?, @cpf=?",
				new Object[] {param.getAsStringOrValue("usuario", ""), param.getAsStringOrValue("email", ""),
								param.getAsStringOrValue("cpf", "")});
	}
	
	public Registro salvarNovaSenha(Registro param) {
		return dao.getRowAsRegistro("EXEC sistema.salvarNovaSenha @senha=?, @id=?",
				new Object[] {Criptografia.encripta(param.getAsStringOrValue("senha", "")), param.getAsIntOrZero("id")});
	}
	
	
}
