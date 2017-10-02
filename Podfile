workspace 'IdylleClient.xcworkspace'

## Frameworks targets
abstract_target 'Frameworks' do
	use_frameworks!
	target 'IdylleClient-iOS' do
		platform :ios, '8.0'
	end

	target 'IdylleClient-watchOS' do
		platform :watchos, '2.0'
	end

	target 'IdylleClient-tvOS' do
		platform :tvos, '9.0'
	end

	target 'IdylleClient-OSX' do
		platform :osx, '10.10'
	end
end

## Tests targets
abstract_target 'Tests' do
	use_frameworks!
	target 'IdylleClientTests-iOS' do
		platform :ios, '8.0'
	end

	target 'IdylleClientTests-tvOS' do
		platform :tvos, '9.0'
	end

	target 'IdylleClientTests-OSX' do
		platform :osx, '10.10'
	end
end

## Samples targets
abstract_target 'Samples' do
	use_frameworks!
	target 'IdylleClientSample-iOS' do
		project 'Samples/IdylleClientSample-iOS/IdylleClientSample-iOS'
		platform :ios, '8.0'
	end

	abstract_target 'watchOS' do
		project 'Samples/IdylleClientSample-watchOS/IdylleClientSample-watchOS'
		target 'IdylleClientSample-watchOS' do
			platform :ios, '8.0'
		end

		target 'IdylleClientSample-watchOS WatchKit Extension' do
			platform :watchos, '2.0'
		end
	end

	target 'IdylleClientSample-tvOS' do
		project 'Samples/IdylleClientSample-tvOS/IdylleClientSample-tvOS'
		platform :tvos, '9.0'
	end

	target 'IdylleClientSample-OSX' do
		project 'Samples/IdylleClientSample-OSX/IdylleClientSample-OSX'
		platform :osx, '10.10'
	end
end
