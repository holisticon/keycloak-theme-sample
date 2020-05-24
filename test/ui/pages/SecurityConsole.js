import Common from "./Common";
import Page from "../utils/Page";

import Homepage from "./Homepage";

export default class SecurityConsole extends Page {
  selector = $(".keycloak-body");

  get = () => {
    const homepage = new Homepage();
    homepage.get();
    homepage.getLoginForm().click();
    this.waitForElementUntilDisplayed(this.selector);
  };

  getCommon = () => new Common();
}
