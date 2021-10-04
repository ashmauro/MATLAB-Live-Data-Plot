function[] = PumpDataAnalysis(hObject)
%PumpDataAnalysis This function obtains a FileID or Serial port number from
%                 PumpGUI and calculates selected varibales with the data 
%                 against a Timer.
% 
%                 Opens Plots of certain axes and live plots calculated
%                 data on GUI.
%
%                 NOTE: File being analysed MUST be located in the same
%                 folder as program files.
%
%                 NOTE: Only pre-recorded data availiable at this time.


handles = guidata(hObject);

%Assign Variables
persistent pdata;
persistent tmr;

pdata.P = [];   %Pressure (kPa)
pdata.Q = [];   %Flow rate (L/s)
pdata.h = [];   %Head (m)
pdata.H = [];   %Hydraulic Power (W)
pdata.Vs = 5;    %Supply Voltage (Vdc)
pdata.LPC = 330; %Litres per count
pdata.D = 1000;  %Density (water) (kg/m^3)
pdata.G = 9.81;  %Gravity (m/s^2)
pdata.t = [0];   %Time (sec)

% Obtain file ID
fileID = handles.value; 

%Open Plots
handles.plot1 = plot(handles.pressurevstime,0,0,'.','MarkerSize', 15,'LineStyle', ':');
handles.plot2 = plot(handles.flowratevstime,0,0,'.','MarkerSize', 15,'LineStyle', ':');
handles.plot3 = plot(handles.headvsflowrate,0,0,'.','MarkerSize', 15,'LineStyle', ':');
handles.plot4 = plot(handles.hpowervsflowrate,0,0,'.','MarkerSize', 15,'LineStyle', ':');

%Set all axis labels
title(handles.pressurevstime, 'Pressure vs Time');
xlabel(handles.pressurevstime, 'Time (s)');
ylabel(handles.pressurevstime, 'Pressure (kPa)');

title(handles.flowratevstime, 'Flowrate vs Time');
xlabel(handles.flowratevstime, 'Time (s)');
ylabel(handles.flowratevstime, 'Flowrate (L/s)');

title(handles.headvsflowrate, 'Head vs Flowrate');
xlabel(handles.headvsflowrate, 'Flowrate (L/s)');
ylabel(handles.headvsflowrate, 'Head (Pa)');

xlabel(handles.hpowervsflowrate, 'Flowrate (L/s)');
ylabel(handles.hpowervsflowrate, 'Hydraulic Power (W)');
title(handles.hpowervsflowrate, 'Hydraulic Power vs Flowrate');

% Create timer
tmr = timer;
tmr.TimerFcn = @timer_callback;
tmr.Period = 0.5;
tmr.ExecutionMode = 'fixedSpacing';


start(tmr);
   
    function timer_callback(obj, event)
        
        dataline = fgetl(fileID);
    
            if ~ischar(dataline)

                stop(obj);
                fclose(fileID);
                disp('ERROR, OUT OF DATA')

            end

            if handles.stopbutton.Value == 1

                stop(obj)
                disp('STOPPED BY USER')
                fclose(fileID);

            end
    

        % Scan line of data
        datascan = sscanf(dataline, '%f V,%f counts,%f ms');

        % Calculations
        pdata.P(end+1) = (((datascan(1) / pdata.Vs) - 0.04) / 0.0018); % Pressure (kPa)
        pdata.Q(end+1) = ((datascan(2) * 2) / pdata.LPC);              % Flow Rate (L/s)
        pdata.h(end+1) = (pdata.P(end) * 1000) / (pdata.D * pdata.G);  % Head Pressure (Pa)
        pdata.H(end+1) = (pdata.Q(end) * pdata.P(end)) / 1000;         % Hydraulic Power (W)
       
        if length(pdata.P) > 1
            pdata.t(end+1) = pdata.t(end) + tmr.Period;
        end 
        

        % Update Plots
        set(handles.plot1, 'XData', pdata.t, 'YData', pdata.P);
        set(handles.plot2, 'XData', pdata.t, 'YData', pdata.Q);
        set(handles.plot3, 'XData', pdata.t, 'YData', pdata.h);
        set(handles.plot4, 'XData', pdata.t, 'YData', pdata.H);

        drawnow limitrate; 

    end

end