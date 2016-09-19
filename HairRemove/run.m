clc;clear;close all;
warning('off');

imaqhwinfo
obj = videoinput('winvideo', 1, 'MJPG_640x480');
triggerconfig(obj, 'manual');
start(obj);
figure;
for i = 1 : 20
    img_rgb = getsnapshot(obj);
    img_rgb = preProccess(img_rgb);
%     imshow([img_rgb, img_res, img_lab]);
% % %     
% % %     
    r = img_rgb(:, :, 1);g = img_rgb(:, :, 2);b = img_rgb(:, :, 3);

    [img_skin, bw_skin] = SkinDetecte(img_rgb);
%     figure;imshow([img_rgb, img_skin]);

    [img_hair, bw_hair] = HairDetecte(img_rgb);
%     figure;imshow([img_rgb, img_hair]);

    img_res = uint8( zeros( size(img_rgb) ) );
    img_resR = uint8( zeros( size(r) ) );
    img_resG = img_resR;
    img_resB = img_resR;

    pos_skin = find(bw_skin == 1 & bw_hair == 0);       % Æ¤·ô£¨ÂÌ£©
    img_resR(pos_skin) = 0;
    img_resG(pos_skin) = 255;
    img_resB(pos_skin) = 0;

    pos_hair = find(bw_skin == 0 & bw_hair == 1);       % Ã«·¢£¨À¶£©
    img_resR(pos_hair) = 0; % r(pos_hair);
    img_resG(pos_hair) = 0;
    img_resB(pos_hair) = 255;

    pos_both = find(bw_skin == 1 & bw_hair == 1);       % ¶¼ÊÇ£¨ºì£©
    img_resR(pos_both) = 255;
    img_resG(pos_both) = 0;
    img_resB(pos_both) = 0;

    img_res(:, :, 1) = img_resR;
    img_res(:, :, 2) = img_resG;
    img_res(:, :, 3) = img_resB;

    imshow([img_rgb, img_res]);
    title('ÂÌ----Æ¤·ô     À¶----Ã«·¢     ºì----¶¼ÊÇ');
    pause(0.033);
end
stop(obj);
delete(obj);