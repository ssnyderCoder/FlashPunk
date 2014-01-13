package tests 
{
	import asunit.framework.TestCase;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TestAlarmFP extends TestCase 
	{
		private var alarmSetOff:Boolean = false;
		
		public function TestAlarmFP(testMethod:String=null) 
		{
			super(testMethod);
			FP.timeInFrames = false;
			reset();
		}
		
		public function testAlarmCallback():void {
			var delayTimeInSeconds:Number = 2;
			var alarm:Alarm = FP.alarm(delayTimeInSeconds, alarmComplete);
			timePasses(delayTimeInSeconds / 2);
			assertFalse("Alarm should not have triggered yet", alarmSetOff);
			timePasses(delayTimeInSeconds * 9);
			assertTrue("Alarm should have triggered", alarmSetOff);
			reset();
		}
		
		private function timePasses(seconds:Number):void 
		{
			FP.elapsed += seconds;
			FP.tweener.updateTweens();
		}
		
		private function reset():void 
		{
			FP.elapsed = 0;
			alarmSetOff = false;
			
		}
		
		private function alarmComplete():void {
			alarmSetOff = true;
		}
		
	}

}