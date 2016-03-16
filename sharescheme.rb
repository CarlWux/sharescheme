#!/usr/bin/env ruby
require 'optparse'
require 'fileutils'
def sharedScheme(projectpath)
  puts projectpath
  sharefilepath={}
  sharefilepath[:xcodeproj]=nil
  Dir::glob("#{projectpath}/*.xcodeproj") do |variable|
    Dir.chdir("#{variable}")
  end
  puts Dir.getwd
  #先看看是不是已经共享了
  Dir.glob("./xcshareddata/xcschemes/*.xcscheme") do |variable|
    puts "工程的scheme已经共享了"
    return;
  end

  puts "没有共享，先在xcuserdatad 下找到工程名.xcscheme 的文件"
  FileUtils.mkdir_p "#{Dir.getwd}/xcshareddata/xcschemes"
  # puts "xcuserdata 目录为 #{Dir.getwd}"
  sharedresult=false
  Dir.glob("./*/*.xcuserdatad/xcschemes/*.xcscheme") do |variable|
    puts "#{File.absolute_path("#{variable}")}"
    FileUtils.move("#{File.absolute_path("#{variable}")}","#{Dir.getwd}/xcshareddata/xcschemes")
    sharedresult=true
  end

  if sharedresult==true
    puts "设置共享成功"
  else
    puts "设置共享失败"
  end
end

options={}
option_parser=OptionParser.new do |opts|
  # 这里是这个命令行工具的帮助信息
  opts.banner = '将工程设置为shared的脚本'

  options[:path]=nil
  #Option 作为 flag，带argument，用于获取工程文件的路径，比如"path"信息

  opts.on('-p path','--path path','设置工程完整路径')  do |value|
    options[:path]=value
  end

end.parse!

# puts options.inspect
sharedScheme(options[:path])
