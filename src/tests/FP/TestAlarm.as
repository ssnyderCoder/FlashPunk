package tests.FP 
{
	import asunit.framework.TestCase;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.Tweener;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * @author Sean Snyder
	 */
	public class TestAlarm extends TestCase 
	{
		private static const DURATION_IN_SECONDS:int = 200;
		private var alarmTriggerCount:int = 0;
		
		public function TestAlarm(testMethod:String=null) 
		{
			super(testMethod);
			FP.timeInFrames = false;
			reset();
		}
		
		public function testAlarmWhenNoTimePasses():void {
			setupAlarm();
			timePasses(0);
			assertTrue("Alarm should not have triggered", alarmTriggerCount == 0);
		}
		
		public function testAlarmWhenNotEnoughTimePasses():void {
			setupAlarm();
			timePasses(DURATION_IN_SECONDS / 2);
			assertTrue("Alarm should not have triggered yet", alarmTriggerCount == 0);
		}
		
		public function testAlarmWhenEnoughTimePasses():void {
			setupAlarm();
			timePasses(DURATION_IN_SECONDS);
			assertTrue("Alarm should have triggered", alarmTriggerCount == 1);
		}
		
		public function testAlarmLoopingCallback():void {
			setupAlarm(null, Tween.LOOPING);
			
			timePasses(DURATION_IN_SECONDS);
			assertTrue("Alarm should have triggered once", alarmTriggerCount == 1);
			timePasses(DURATION_IN_SECONDS);
			assertTrue("Alarm should have triggered twice", alarmTriggerCount == 2);
		}
		
		public function testAlarmWithTweener():void {
			var tweener:Tweener = new Tweener();
			setupAlarm(tweener);
			
			timePasses(DURATION_IN_SECONDS / 2, tweener);
			assertTrue("Alarm should not have triggered yet", alarmTriggerCount == 0);
			
			timePasses(DURATION_IN_SECONDS / 2, tweener);
			assertTrue("Alarm should have triggered once", alarmTriggerCount == 1);
		}
		
		private function timePasses(seconds:Number, tweener:Tweener=null):void 
		{
			FP.elapsed += seconds;
			FP.tweener.updateTweens();
			if (tweener) tweener.updateTweens();
		}
		
		private function setupAlarm(tweener:Tweener=null,type:int=Tween.ONESHOT):void 
		{
			reset();
			FP.alarm(DURATION_IN_SECONDS, alarmTriggered, type, tweener);
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