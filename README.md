## 🧱 Simple Bloc

Phiên bản đơn giản của BloC, bao gồm các thành phần chính:

### 1. `Bloc<Event, State>`

- **Vai trò:** Là lớp cốt lõi điều phối `Event` và phát `State`.
- **Chức năng chính:**
  - Nhận `Event` qua `add(event)`
  - Chuyển đổi `Event` thành `State` qua `mapEventToState`
  - Quản lý stream `State` để UI có thể lắng nghe và rebuild.

```dart
abstract class Bloc<Event, State> {
  void add(Event event);                // Gửi event
  Stream<State> get stream;            // Stream trạng thái
  State get state;                     // Trạng thái hiện tại
  Stream<State> mapEventToState(Event event); // Logic xử lý event
}
```

---

### 2. `BlocProvider`

- **Vai trò:** Cung cấp `Bloc` xuống cây widget.
- **Cách hoạt động:** Lưu bloc trong một widget kế thừa `InheritedWidget`, giúp truy xuất bloc từ bất kỳ widget con nào bằng `BlocProvider.of(context)`.

```dart
late final CounterBloc _counterBloc;

@override
void initState() {
  super.initState();
  _counterBloc = CounterBloc();
}

@override
void dispose() {
  _counterBloc.dispose();
  super.dispose();
}

BlocProvider(
  bloc: _counterBloc,
  child: YourPage()
)
```

---

### 3. `BlocBuilder`

- **Vai trò:** Lắng nghe `Stream<State>` và tự động rebuild UI khi có `State` mới.
- **Cách sử dụng:** Truyền `stream`, `initialState`, và hàm `builder`.

```dart
BlocBuilder<CounterState>(
  stream: counterBloc.stream,
  initialState: counterBloc.state,
  builder: (context, state) {
    int count = 0;
    if (state is CounterInitial) {
      count = state.count;
    } else if (state is CounterChanged) {
      count = state.count;
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Count: $count',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () => counterBloc.add(DecrementEvent()),
                child: Icon(Icons.remove),
              ),
              FloatingActionButton(
                onPressed: () => counterBloc.add(ResetEvent()),
                child: Icon(Icons.refresh),
              ),
              FloatingActionButton(
                onPressed: () => counterBloc.add(IncrementEvent()),
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  },
),
```

---

### 4. `BlocListener`

- **Vai trò:** Lắng nghe thay đổi `State` và thực hiện **side-effect** (ví dụ: hiển thị snackbar, điều hướng, v.v).
- **Không rebuild UI.**

```dart
BlocListener<CounterState>(
  stream: counterBloc.stream,
  initialState: counterBloc.state,
  listener: (context, state) {
    if (state is CounterChanged && state.count == 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đếm đến 10!')),
      );
    }
  },
)
```