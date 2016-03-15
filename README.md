# sharescheme
share Xcode use command line

iOS在做持续集成的时候总会碰到一个蛋疼的问题：必须将工程文件对应的scheme设置成shared不然xcodebuild 在执行"xcodebuild -list"这个命令的时候会找不到这个scheme,每次都需要开发人员手动设置然后提交代码。于是就写了这个脚本再打包的时候将对应工程的scheme设置成shared



when use CI to build xcode project ,we must set scheme shared,or "xcodebuild -list" can't find the scheme.so i write this ruby script to share the scheme


