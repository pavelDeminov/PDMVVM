
Pod::Spec.new do |s|

  s.name         = "PDMVVM"
  s.version      = "0.0.4"
  s.platform = :ios

  s.swift_versions = "5.0"

  s.ios.deployment_target = '9.0'
  s.summary      = "Template for implementation MVVM Pattern"

  s.homepage     = "https://github.com/sindanar/PDMVVM"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Pavel Deminov" => "pavel.d.work@gmail.com" }

  s.source       = { :git => "https://github.com/sindanar/PDMVVM.git", :tag => "0.0.4" }
  
  s.subspec "Base" do | base |
    	base.source_files = "PDMVVM/Base/**/*.swift"
  end

  s.subspec "Section" do | section |
    	section.source_files = "PDMVVM/Section/**/*.swift"
	section.dependency 'PDMVVM/Base'
  end

  s.subspec "Collection" do | collection |
    	collection.source_files = "PDMVVM/Collection/**/*.swift"
	collection.dependency 'PDMVVM/Section'
  end


end
