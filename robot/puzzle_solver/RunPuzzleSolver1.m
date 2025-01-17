function [ Pieces,SIZE ] = RunPuzzleSolver1(Im, CameraImageAxes, CapturedImageAxes, JumbledPiecesAxes, SolutionAxes, showWorkAreaDetection, showRoughBlockSeparation, showOnlyBestEstimatedSolution, showEachPiece)
%RunPuzzleSolver - Acquire puzzle pieces from image, attempt to solve
%puzzle

%clc;
%clear all;
%close all;

%showRoughBlockSeparation = true;
%showWorkAreaDetection = true;
%showFinalPiecesBeforeSolving = true;
% showOnlyBestEstimatedSolution = true;
% showEachPiece = 0;  % 0 - no output
                                             % 1 - only piece rotation and cropping
                                             % 2 - also show step identifying each piece closely
% PieceCornerMethod = 3;  % choose 1, 2 or 3

% Im = imread('D:\RobotFiles_WithDLL_FromYaron\test.jpg');

Im = black_correction(Im);

%% Identify work area using blue markers
p1 = FindWorkAreaCorners(Im, showWorkAreaDetection);

% Second set of points is pre-determined
% p2 = [1, 1; 1, 920; 800, 920; 800, 1];
%p2 = [1, 1; 1, 760; 680, 760; 680, 1]; %shai 2002
p2 = [1, 1; 1, 800; 800, 800; 800, 1]; %shai 0103
Im_rectified = PerformHomography(Im, p1, p2);
corners = FindWorkAreaCorners(Im_rectified, showWorkAreaDetection);
if showWorkAreaDetection 
    figure; imshow(Im_rectified); 
    hold on;
    plot(corners(:, 1), corners(:, 2), '+r');
end

newIm = Im_rectified(round(corners(1,2)):round(corners(3,2)), round(corners(1,1)) : round(corners(3,1)), :);
if showWorkAreaDetection 
    figure; imshow(newIm); end

size(newIm)

% Normalize image size
%%%800 920 shai 1302
Im = imresize(newIm,[800,800]);% shai co 0103 [680,760]);
SIZE = 800;
% factor = SIZE/min(size(Im, 1), size(Im,2));
% Im = imresize(Im, factor);
%imwrite(Im,'tmp.jpg');

%% Separate image into rough segments, each containing one piece 
Pieces = SeparatePieces(Im, showRoughBlockSeparation);

display(['Found ' num2str(size(Pieces,1)) ' pieces']);
