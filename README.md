# Remote realtime control system based on loongson

A project we are in college, in 2009.

## Summary
The system is a real time system run on loongson, control the step motor from browser.  
System structure:  
![Main structure](https://github.com/unanao/remote-rt-control-system/blob/master/image/structure.png)

## Sub-module
Control ui:  
![Contrl ui](https://github.com/unanao/remote-rt-control-system/blob/master/image/stepmotorcotro.png)

## Permission Control
![Login](https://github.com/unanao/remote-rt-control-system/blob/master/image/login.png)

## Real time 
RT-PREEMPT kernel patch to make sure 
`
With Ingo Molnar's Realtime Preemption patch (referenced to as RT-Preempt in this document) and Thomas Gleixner's generic clock event layer with high resolution support, the kernel gains hard realtime capabilities.The RT-Preempt patch converts Linux into a fully preemptible kernel. The magic is done with: 
Making in-kernel locking-primitives (using spinlocks) preemptible though reimplementation with rtmutexes: 
Critical sections protected by i.e. spinlock_t and rwlock_t are now preemptible. The creation of non-preemptible sections (in kernel) is still possible with raw_spinlock_t (same APIs like spinlock_t) 
	Implementing priority inheritance for in-kernel spinlocks and semaphores. For more information on priority inversion and priority inheritance please consult Introduction to Priority Inversion 
	Converting interrupt handlers into preemptible kernel threads: The RT-Preempt patch treats soft interrupt handlers in kernel thread context, which is represented by a task_struct like a common userspace process. However it is also possible to register an IRQ in kernel context. 
	Converting the old Linux timer API into separate infrastructures for high resolution kernel timers plus one for timeouts, leading to userspace POSIX timers with high resolution. 
`
## Security
Netfilter and iptables mechanism.

## Log recording
Recording User's operations and time

## Designer and developer:

| Name | Email |
| -------------- | ----------------------- | 
| Sun Jianjiao   | <jianjiaosun@163.com>   |
| Zhang Yanjiang | <zhyanjiang@126.com>    |
| Liu Quanying   | <liuquanying@gmail.com> |
