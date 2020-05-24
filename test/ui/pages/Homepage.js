import Common from "./Common";
import Page from "../utils/Page";

export default class Homepage extends Page {
  selector = $(".container-fluid");

  get = () => {
    /**
     * Browser window will maximize width and height
     */
    browser
      .manage()
      .window()
      .maximize();

    browser.baseUrl = "http://localhost:8888/";
    browser.get("/");
    this.waitUntilDisplayed();
  };

  getLoginForm = () => {
    let link = $("div.welcome-primary-link a");
    this.waitForElementUntilDisplayed(link);
    return link;
  };

  getCommon = () => new Common();
}
