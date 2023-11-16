@Component
export default struct ChildComponent {
  // 禁止在组件内初始化，应由父组件进行初始化
  @Prop counter: number;

  build() {
    Column() {
      Text('ChildComponent')
        .fontSize(30)
        .fontWeight(FontWeight.Bold);
      Text(this.counter + '')
        .fontSize(25)
        .fontWeight(FontWeight.Bold);
      Button('update child status in child')
        .onClick(() => {
          this.counter++;
        })
    }
    .border({
      width: 1,
      color: '#cccccc',
      style: BorderStyle.Solid
    })
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(200)
  }
}