package
{
	import net.flashpunk.Engine;
	import tests.AllTests;
	import asunit.textui.TestRunner;
	
/**
	 * ...
	 * @author Sean Snyder
	 */
	[SWF(width=1000, height=640, frameRate=60, backgroundColor="#000000")]
	public class Main extends Engine 
	{
		public static const SCREEN_WIDTH:int = 1000;
		public static const SCREEN_HEIGHT:int = 640;
		public function Main():void 
		{
			super(SCREEN_WIDTH, SCREEN_HEIGHT, 60, false);
			this.paused = true;
			runUnitTests();
		}
		
		private function runUnitTests():void 
		{
			var unittests:TestRunner = new TestRunner();
			stage.addChild(unittests);
			unittests.start(AllTests, null, TestRunner.SHOW_TRACE);
		}
		
		
	}
	
}