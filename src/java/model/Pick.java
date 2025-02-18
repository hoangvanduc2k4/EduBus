/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalTime;

/**
 *
 * @author DIEN MAY XANH
 */
public class Pick {

    private int studentid;
    private int tripid;
    private int stopid;
    private LocalTime picktime;
    private LocalTime droptime;
    
    public Pick() {
    }

    public Pick(int studentid, int tripid, int stopid, LocalTime picktime, LocalTime droptime) {
        this.studentid = studentid;
        this.tripid = tripid;
        this.stopid = stopid;
        this.picktime = picktime;
        this.droptime = droptime;
    }

    public int getStudentid() {
        return studentid;
    }

    public void setStudentid(int studentid) {
        this.studentid = studentid;
    }

    public int getTripid() {
        return tripid;
    }

    public void setTripid(int tripid) {
        this.tripid = tripid;
    }

    public int getStopid() {
        return stopid;
    }

    public void setStopid(int stopid) {
        this.stopid = stopid;
    }

    public LocalTime getPicktime() {
        return picktime;
    }

    public void setPicktime(LocalTime picktime) {
        this.picktime = picktime;
    }

    public LocalTime getDroptime() {
        return droptime;
    }

    public void setDroptime(LocalTime droptime) {
        this.droptime = droptime;
    }
    
    
}
