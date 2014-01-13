package tests 
{
	import asunit.framework.TestSuite;
	import tests.FP.TestAlarm;
	import tests.FP.TestAnchorTo;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class AllTests extends TestSuite 
	{
		
		public function AllTests() 
		{
			super();
            addTest(new TestAlarm());
			addTest(new TestAnchorTo());
		}
		
	}

}