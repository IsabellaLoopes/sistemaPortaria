package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class MenuDAO {
	private DAO dao;
	
	public MenuDAO(DAO dao) {
		this.dao = dao;
	}
	
	public List<Registro> listarMenu(Registro param) {
		return dao.listaRowAsRegistro("EXEC sistema.listarMenu @nivel=?, @status=?", 
				new Object[] {param.getAsIntOrValue("nivel", -1), param.getAsStringOrValue("status", "")});
	}
	
	public Registro alteraStatusMenu(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.alteraStatusMenu @id=?, @status=?",
				new Object[] {param.getAsIntOrZero("id"), param.getAsString("status")});
	}
	
	public List<Registro> listarPermissoesMenu(Registro param) {
		return dao.listaRowAsRegistro("EXEC cadastro.listarPermissoesMenu @men_id=?",
				new Object[] {param.getAsIntOrZero("idMenu")});
	}
	
	public Registro atribuirPermissaoMenu(Registro param) {
		return dao.getRowAsRegistro("EXEC cadastro.atribuirPermissaoMenu @idMenu=?, @idUser=?",
				new Object[] {param.getAsIntOrZero("idMenu"), param.getAsString("idUser")});
	}
}
