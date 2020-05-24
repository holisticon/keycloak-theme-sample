import UIComponent from "../utils/UIComponent";

export default class Common {

  /**
   * @returns {Footer}
   */
  getFooter = () => new Footer();
}

class Footer extends UIComponent {
  selector = $("#footer");

  social = this.selector.$$("ul.social");
  chicago = this.social.get(0).$$("a"); // eslint-disable-line
  bratislava = this.social.get(1).$$("a"); // eslint-disable-line

  link = {
    email: this.selector.$("[href='mailto:hello@thinkcreatix.com']"),
    chicago: {
      facebook: this.chicago.get(0),
      linkedIn: this.chicago.get(1),
      map: this.chicago.get(2),
    },
    bratislava: {
      facebook: this.bratislava.get(0),
      linkedIn: this.bratislava.get(1),
      map: this.bratislava.get(2),
    },
  };

  copyright = this.selector.$("#copyright");
}
