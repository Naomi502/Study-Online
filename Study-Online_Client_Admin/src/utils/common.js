//格式化日期 年月日时分秒  每天6点
export function formSixDate(hour, minute, second) {
  let date = new Date();
  //将时间设置为06:00:00
  date.setHours(hour);
  date.setMinutes(minute);
  // date.setSeconds(second)
  let h = date.getHours();
  h = h < 10 ? "0" + h : h;
  let m = date.getMinutes();
  m = m < 10 ? "0" + m : m;
  // let s = date.getSeconds()
  // s = s < 10 ? ('0' + s) : s
  let setSixTime = h + ":" + m;

  //当前时间
  let now = new Date();
  let hours = now.getHours();
  hours = hours < 10 ? "0" + hours : hours;
  let min = now.getMinutes();
  min = min < 10 ? "0" + min : min;
  // let sec = now.getSeconds()
  // sec = sec < 10 ? ('0' + sec) : sec
  let nowTime = hours + ":" + min;

  //如果相等返回true否则false
  return setSixTime == nowTime ? true : false;
}
