package ru.rsreu.harbor.controller.exception;

import com.prutzkow.resourcer.Resourcer;
import ru.rsreu.harbor.controller.result.ActionCommandResult;
import ru.rsreu.harbor.controller.result.ActionCommandResultTypes;

import javax.servlet.http.HttpServletRequest;

public class ShowReportPageException extends ActionCommandException {
    @Override
    public ActionCommandResult getActionCommandResult(HttpServletRequest request) {
        request.getSession().setAttribute(
                Resourcer.getString("request.attribute.key.errorMessage"),
                Resourcer.getString("message.error.moderatorUserPage.noSuchReport")
        );
        return new ActionCommandResult(
                Resourcer.getString("command.path.showModeratorReportsPage"),
                ActionCommandResultTypes.SEND_REDIRECT
        );
    }
}
