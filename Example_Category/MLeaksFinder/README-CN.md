Leaks

先看看 Leaks，从苹果的开发者文档里可以看到，一个 app 的内存分三类：

Leaked memory: Memory unreferenced by your application that cannot be used again or freed (also detectable by using the Leaks instrument).

Abandoned memory: Memory still referenced by your application that has no useful purpose.

Cached memory: Memory still referenced by your application that might be used again for better performance.

其中 Leaked memory 和 Abandoned memory 都属于应该释放而没释放的内存，都是内存泄露，而 Leaks 工具只负责检测 Leaked memory，而不管 Abandoned memory。在 MRC 时代 Leaked memory 很常见，因为很容易忘了调用 release，但在 ARC 时代更常见的内存泄露是循环引用导致的 Abandoned memory，Leaks 工具查不出这类内存泄露，应用有限。

# FAQ
**1) 引进 MLeaksFinder 后没生效？**

* 先验证引进是否正确，在 UIViewController+MemoryLeak.m 的 `+ (void)load` 方法里加断点，看 app 启动时有没有进入。

**2) 可以手动引进 MLeaksFinder 吗？**

* 直接把 MLeaksFinder 的代码放到项目里即生效。如果把 MLeaksFinder 做为子工程，需要在主工程的 Build Settings -> Other Linker Flags 加上 `-ObjC`。
* 只是引进 MLeaksFinder 的代码 Retain Cycle 功能还未生效，可以再手动加入 FBRetainCycleDetector 代码，然后把 MLeaksFinder.h 里的 `//#define MEMORY_LEAKS_FINDER_RETAIN_CYCLE_ENABLED 1` 打开。

**3) Fail to find a retain cycle？**

* 内存泄漏不一定是循环引用造成的。
* 有的循环引用 FBRetainCycleDetector 不一定能找出。

**4) 如何关掉 MLeaksFinder？**

* 把 MLeaksFinder.h 里的 `//#define MEMORY_LEAKS_FINDER_ENABLED 0` 打开。
