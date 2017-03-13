(
project=InterviewQuestions
rm -rfv build
mkdir build
xcodebuild -list | tee build/list.txt
for schemeprefix in "InterviewQuestionsFree" "InterviewQuestionsFull"; do
for configuration in "Debug" "Release"; do
	scheme=${schemeprefix}${configuration}
	archivePath=build/${scheme}.xcarchive
	exportPath=build/${scheme}.ipa
	xcodebuild -scheme ${scheme} -configuration ${configuration} -showBuildSettings | tee build/${scheme}.xcconfig
	xcodebuild -scheme ${scheme} -configuration ${configuration} -archivePath ${archivePath} -verbose clean build archive -IDEBuildOperationMaxNumberOfConcurrentCompileTasks=1 | tee build/cleanBuildArchive${scheme}.txt
	xcodebuild -archivePath ${archivePath} -exportArchive -exportFormat IPA -exportPath ${exportPath} -verbose -IDEBuildOperationMaxNumberOfConcurrentCompileTasks=1 | tee build/exportArchive${scheme}.txt
done
done
)