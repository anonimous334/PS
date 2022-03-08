clear all 
close all
 
% [audio_train,labels_train, audio_test,labels_test] = load_data();
load('data.mat')
plot_figs = true;
 
% For faster results use just a fraction of each audio file 
% The results will be poorer but the speed would improve
% select a fraction of alpha percents of each file 
alpha = 1 / 1000;
b = floor(size(audio_train,1) / 2 - alpha * size(audio_train,1) / 2 + 1);
e = floor(size(audio_train,1) / 2 + alpha * size(audio_train,1) / 2);
audio_train_small = audio_train(b:e,:);
b = floor(size(audio_train,1) / 2 - alpha * size(audio_train,1) / 2 + 1);
e = floor(size(audio_train,1) / 2 + alpha * size(audio_train,1) / 2);
audio_test_small = audio_test(b:e,:);
 
% calculam vectorii de trasaturi pentru fiecare fisier din datasetul de train si de  test
% get_features primeste toate sunetele din set date intr-o matrice (audio_train)
% de dimensiune: numar_ensantioane x numar_sunete si returneaz� toate
% featurile acestor sunete intr-o matrice (feat_train) de dimensiune numar_sunete x (2*M)
% alaturi de setul de filtre h folosite (filters) reprezentat de o matrice de dimeniune K x M
 
% TODO: calculati featurile folosind un set de M filtre Gammatone
% plot_figs == true afisati figurile cerute in tema
 
[filters, feat_train] = get_features(audio_train_small, fs, plot_figs);
[filters, feat_test] = get_features(audio_test_small, fs, plot_figs);
 
% size(audio_train) = numar_ensantioane x numar_sunete = 160704 x 300
% size(feat_train)  = numar_sunete x (2*M) = 300 x 24
% size(filters)     = K  x   M
 
% antrenam un clasificator
model = train_sc(feat_train,labels_train,'LDA');
 
% prezicem clasele pentru datasetul de train si de test
results_train = test_sc(model,feat_train);
results_test = test_sc(model,feat_test);
 
% calculam acuratetea pe train si test
acc_train = mean(results_train.classlabel(:) == labels_train(:));
acc_test  = mean(results_test.classlabel(:) == labels_test(:));
 
sprintf('Accuracy on train: %0.2f', acc_train);
sprintf('Accuracy on test: %0.2f', acc_test);
 
 
% TODO: verificati calitativ cateva exemple din setul de test. 
% comparati clasa corecta si clasa presiza cu sunetul auzit
 
% alegem random un fisier audio si verificam daca am clasificat corect
% labels_name = ["Dog"; "Rooster"; "Rain" ; "Waves"; "Fire"; "Baby"; ...
%     "Sneezing"; "Clock"; "Helicopter"; "Chainsow"];
% 
% r = round(rand() * 100);
% sound(audio_test(:,r),fs);
% sprintf('Clasa corecta: %s', labels_name(labels_test(r),:))
% sprintf('Clasa prezisa: %s', labels_name(results_test.classlabel(r),:))