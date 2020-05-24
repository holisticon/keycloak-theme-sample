import SecurityConsole from "./pages/SecurityConsole";

const securityConsole = new SecurityConsole();

describe("SecurityConsole", () => {
  describe("when on SecurityConsole", () => {
    beforeAll(() => {
      securityConsole.get();
    });

    it("then login form should be displayed", () => {
      expect(securityConsole.isDisplayed()).toBe(true);
    });
  });
});
