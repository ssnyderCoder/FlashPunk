package tests 
{
	import asunit.framework.TestCase;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TestAlarmFP extends TestCase 
	{
		private var alarmTriggerCount:int = 0;
		
		public function TestAlarmFP(testMethod:String=null) 
		{
			super(testMethod);
			FP.timeInFrames = false;
			reset();
		}
		
		public function testAlarmSingleCallback():void {
			var durationInSeconds:Number = 200;
			FP.alarm(durationInSeconds, alarmTriggered);
			assertTrue("Trigger count should be 0", alarmTriggerCount == 0);
			
			timePasses(durationInSeconds / 2);
			assertTrue("Alarm should not have triggered yet", alarmTriggerCount == 0);
			
			timePasses(durationInSeconds / 2);
			assertTrue("Alarm should have triggered once", alarmTriggerCount == 1);
			
			reset();
		}
		
		public function testAlarmLoopingCallback():void {
			var durationInSeconds:Number = 500;
			var alarm:Alarm = FP.alarm(durationInSeconds, alarmTriggered, Tween.LOOPING);
			
			timePasses(durationInSeconds);
			assertTrue("Alarm should have triggered once", alarmTriggerCount == 1);
			timePasses(durationInSeconds);
			assertTrue("Alarm should have triggered twice", alarmTriggerCount == 2);
			
			timePasses(durationInSeconds);
			timePasses(durationInSeconds);
			timePasses(durationInSeconds);
			assertTrue("Alarm should have triggered 5 times", alarmTriggerCount == 5);
			
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
			FP.tweener.clearTweens();
			alarmTriggerCount = 0;
		}
		
		private function alarmTriggered():void {
			alarmTriggerCount++;
		}
		
	}

}