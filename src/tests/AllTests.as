package tests 
{
	import asunit.framework.TestSuite;
	import tests.TestAlarmFP;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class AllTests extends TestSuite 
	{
		
		public function AllTests() 
		{
			super();
            addTest(new TestAlarmFP());
		}
		
	}

}