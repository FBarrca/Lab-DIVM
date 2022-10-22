function [H_A01,H_A02,H_A03,H_A04,H_A05,H_A06] = saveTrajectory(A01,A02,A03,A04,A05,A06,H_A01,H_A02,H_A03,H_A04,H_A05,H_A06)
    H_A01(:,:,size(H_A01,3)+1)= A01;
    H_A02(:,:,size(H_A02,3)+1)= A02;
    H_A03(:,:,size(H_A03,3)+1)= A03;
    H_A04(:,:,size(H_A04,3)+1)= A04;
    H_A05(:,:,size(H_A05,3)+1)= A05;
    H_A06(:,:,size(H_A06,3)+1)= A06;
    plotTrajectory(H_A01);
    plotTrajectory(H_A02);
    plotTrajectory(H_A03);
    plotTrajectory(H_A04);
    plotTrajectory(H_A05);
    plotTrajectory(H_A06);
end

