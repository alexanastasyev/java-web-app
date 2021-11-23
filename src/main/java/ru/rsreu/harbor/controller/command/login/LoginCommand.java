package ru.rsreu.harbor.controller.command.login;

import com.prutzkow.resourcer.Resourcer;
import ru.rsreu.harbor.controller.command.ActionCommand;
import ru.rsreu.harbor.controller.result.ActionCommandResult;
import ru.rsreu.harbor.controller.result.ActionCommandResultTypes;

import javax.servlet.http.HttpServletRequest;

public class LoginCommand implements ActionCommand {
    private static final String LOGIN_PARAMETER_NAME = "login";
    private static final String PASSWORD_PARAMETER_NAME = "password";

    private final LoginCommandLogic loginCommandLogic;

    public LoginCommand(LoginCommandLogic loginCommandLogic) {
        this.loginCommandLogic = loginCommandLogic;
    }

    @Override
    public ActionCommandResult execute(HttpServletRequest request) {
        String page;

        String login = request.getParameter(LOGIN_PARAMETER_NAME);
        String password = request.getParameter(PASSWORD_PARAMETER_NAME);

        if (loginCommandLogic.checkLogin(login, password)) {
            page = Resourcer.getString("command.path.showMainPage");
            request.getSession().setAttribute(
                    Resourcer.getString("request.mainPage.attribute.user"), login
            );
            request.getSession().setAttribute(Resourcer.getString("session.attribute.name.role"),
                    this.loginCommandLogic.getUserRole(login));
            request.getSession().setAttribute(Resourcer.getString("session.attribute.name.status"),
                    this.loginCommandLogic.getUserStatus(login));
        } else {
            request.setAttribute(Resourcer.getString("request.attribute.errorLoginPassMessage"),
                    Resourcer.getString("message.loginError"));
            page = Resourcer.getString("command.path.showLoginPage"); 
        }

        return new ActionCommandResult(page, ActionCommandResultTypes.SEND_REDIRECT);
    }
}
