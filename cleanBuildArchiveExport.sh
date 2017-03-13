(
project=InterviewQuestions
rm -rfv build
mkdir build
xcodebuild -list | tee build/list.txt
for scheme in "InterviewQuestionsFree" "InterviewQuestionsFull"; do
for configuration in "Debug" "Release"; do
	archivePath=build/${scheme}${configuration}.xcarchive
	exportPath=build/${scheme}${configuration}.ipa
	xcodebuild -scheme ${scheme} -configuration ${configuration} -showBuildSettings | tee build/${scheme}${configuration}.xcconfig
	xcodebuild -scheme ${scheme} -configuration ${configuration} -archivePath ${archivePath} -verbose clean build archive -IDEBuildOperationMaxNumberOfConcurrentCompileTasks=1 | tee build/cleanBuildArchive${scheme}${configuration}.txt
	xcodebuild -archivePath ${archivePath} -exportArchive -exportFormat IPA -exportPath ${exportPath} -verbose -IDEBuildOperationMaxNumberOfConcurrentCompileTasks=1 | tee build/exportArchive${scheme}${configuration}.txt
done
done
)